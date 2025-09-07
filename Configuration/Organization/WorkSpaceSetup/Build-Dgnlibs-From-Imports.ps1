# Placeholder script: copies curated DGNLibs into discipline folders.
# Replace with your corporate export process after importing XMLs into DGNLibs.
param(
  [string]$StandardsRoot
)
if (-not $StandardsRoot) { $StandardsRoot = "$PSScriptRoot\..\..\Organization-Civil\Standards" }
$src = Join-Path $StandardsRoot "Dgnlib\Common"
$dsts = @("Feature Definitions","Feature Symbology","Element Templates")
foreach ($d in @("CH","CD","CE","CB","CX")) {
  foreach ($bucket in $dsts) {
    $tgt = Join-Path $StandardsRoot "Dgnlib\$bucket\$d"
    New-Item -ItemType Directory -Force -Path $tgt | Out-Null
    # Copy any prepared libs (update pattern for your org names)
    Get-ChildItem -Path $src -Filter "*.dgnlib" -File -ErrorAction SilentlyContinue | ForEach-Object {
      Copy-Item $_.FullName -Destination (Join-Path $tgt $_.Name) -Force
    }
  }
}
Write-Host "Copied common libs into discipline buckets. Replace with your own export process."