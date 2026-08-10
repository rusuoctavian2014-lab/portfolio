@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$root = Join-Path (Get-Location) 'images'; $items = @(); Get-ChildItem $root -Recurse -File | Where-Object { $_.Extension -match '^\.(jpg|jpeg|png|webp|gif)$' } | ForEach-Object { $rel=$_.FullName.Substring((Get-Location).Path.Length+1).Replace('\','/'); $parts=$rel.Split('/'); $cat=$parts[1]; $items += [PSCustomObject]@{path=$rel;category=$cat;title=$_.BaseName} }; $json='window.PORTFOLIO_IMAGES = '+($items | ConvertTo-Json -Compress -Depth 4)+';'; Set-Content -Encoding UTF8 'gallery.js' $json"
echo.
echo Portfolio updated successfully.
echo Open index.html in your browser.
pause
