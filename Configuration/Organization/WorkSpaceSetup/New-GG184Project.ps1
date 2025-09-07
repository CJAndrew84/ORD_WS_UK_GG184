param(
  [Parameter(Mandatory=$true)][string]$ProjectRoot
)
$disciplines = @("CH","CD","CE","CB","CX")
foreach ($d in $disciplines) {
  $dir = Join-Path $ProjectRoot $d
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  New-Item -ItemType File -Force -Path (Join-Path $dir "._GG184_DISCIPLINE_$d") | Out-Null
}
Write-Host "Created discipline folders and marker files under $ProjectRoot"