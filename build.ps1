# Builds checklist.html (artifact format) and index.html (standalone, for GitHub Pages)
# from template.html + games.json. Always read/write explicit UTF-8: Windows PowerShell's
# Get-Content defaults to ANSI and mangles en-dashes and accented characters.
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$utf8 = [System.Text.Encoding]::UTF8
$json = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\games.json")).Trim()
$owner = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\owner-list.json")).Trim()
$html = $utf8.GetString([System.IO.File]::ReadAllBytes("$dir\template.html"))
$page = $html.Replace("__GAMES_DATA__", $json).Replace("__OWNER_DATA__", $owner)
$bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText("$dir\checklist.html", $page, $bom)
[System.IO.File]::WriteAllText("$dir\index.html", "<!doctype html>`n<html lang=`"en`">`n" + $page + "`n</html>", $bom)
Write-Host "Built checklist.html and index.html"
