$imgPath = Get-ChildItem 'C:\Users\Potes\.gemini\antigravity-ide\brain\c5d900a4-fd76-4fcd-b762-6b7ba07bc2ec\portrait_photo_*.png' | Select-Object -First 1 -ExpandProperty FullName
Write-Host "Image path: $imgPath"

$bytes = [System.IO.File]::ReadAllBytes($imgPath)
$b64 = [Convert]::ToBase64String($bytes)
Write-Host "Base64 length: $($b64.Length)"

$htmlPath = 'C:\Users\Potes\.gemini\antigravity-ide\scratch\rushikesh-portfolio\index.html'
$html = [System.IO.File]::ReadAllText($htmlPath)

$dataUri = "data:image/png;base64,$b64"

# Find and replace the SVG placeholder src
$pattern = 'src="data:image/svg\+xml[^"]*"'
$replacement = "src=`"$dataUri`""

$newHtml = [regex]::Replace($html, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::None)

[System.IO.File]::WriteAllText($htmlPath, $newHtml)
Write-Host "Done! Portrait embedded successfully."
