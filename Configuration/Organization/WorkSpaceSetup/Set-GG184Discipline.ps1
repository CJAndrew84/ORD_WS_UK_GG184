param(
  [ValidateSet("CH","CD","CE","CB","CX")][string]$Discipline = "CH",
  [string]$Folder = "."
)
$Folder = Resolve-Path $Folder
# Remove existing markers
Get-ChildItem -Path $Folder -Force -Filter "._GG184_DISCIPLINE_*" | Remove-Item -Force -ErrorAction SilentlyContinue
# Add the requested marker
New-Item -ItemType File -Force -Path (Join-Path $Folder "._GG184_DISCIPLINE_$Discipline") | Out-Null
Write-Host "Set GG184 discipline to $Discipline in $Folder"