# Builds checklist.html (artifact format) and index.html (standalone, for GitHub Pages)
# from template.html + games.json. Always read/write explicit UTF-8: Windows PowerShell's
# Get-Content defaults to ANSI and mangles en-dashes and accented characters.
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$utf8 = [System.Text.Encoding]::UTF8
$json = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\games.json")).Trim()
$owner = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\owner-list.json")).Trim()
$html = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\template.html"))

# Badge sprites: inline each mapped PNG as a data URI so the single-file
# artifact build works too (its CSP blocks external images).
$spriteMap = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\sprite-map.json")) | ConvertFrom-Json
$spriteEntries = foreach ($p in $spriteMap.PSObject.Properties) {
    $file = "$dir\sprites\$($p.Value[0])-$($p.Value[1])"
    if (Test-Path $file) {
        $b64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($file))
        $key = $p.Name.Replace('\', '\\').Replace('"', '\"')
        "`"$key`":`"data:image/png;base64,$b64`""
    }
}
$sprites = "{" + ($spriteEntries -join ",") + "}"

$page = $html.Replace("__GAMES_DATA__", $json).Replace("__OWNER_DATA__", $owner).Replace("__SPRITE_DATA__", $sprites)
$bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText("$dir\checklist.html", $page, $bom)
[System.IO.File]::WriteAllText("$dir\index.html", "<!doctype html>`n<html lang=`"en`">`n" + $page + "`n</html>", $bom)
Write-Host "Built checklist.html and index.html (sprites: $(@($spriteEntries).Count))"
