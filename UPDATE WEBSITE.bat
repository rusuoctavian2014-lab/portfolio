@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$root=Join-Path (Get-Location) 'images'; $items=@(); Get-ChildItem $root -Recurse -File | Where-Object { $_.Extension -match '^\.(jpg|jpeg|png|webp|gif)$' } | ForEach-Object { $rel=$_.FullName.Substring((Get-Location).Path.Length+1).Replace('\','/'); $parts=$rel.Split('/'); if($parts.Count -ge 3){$items += [PSCustomObject]@{path=$rel;category=$parts[1];title=$_.BaseName}} }; $json='window.PORTFOLIO_IMAGES = '+($items|ConvertTo-Json -Compress -Depth 4)+';'; Set-Content -Encoding UTF8 'gallery.js' $json"
echo.
echo ==========================================
echo   OCTAVIAN RUSU PORTFOLIO UPDATED
echo ==========================================
echo.
echo Open index.html to preview the website.
echo Then upload the changed files to GitHub.
pause
