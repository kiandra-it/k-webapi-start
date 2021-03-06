param (
    [string]$version,
    [string]$apiKey,
    [switch]$push = $false
)

if (!(Test-Path ".\pack"))
{
  mkdir pack
}

$nuget = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(".\pack\nuget.exe")

if (!(Test-Path "$nuget")){
  $webclient = New-Object System.Net.WebClient
  $webclient.DownloadFile("https://dist.nuget.org/win-x86-commandline/latest/nuget.exe", $nuget)
}

& $nuget pack .\Package.nuspec -output .\pack -version $version

if ($push) {
  & $nuget push ".\pack\WebApi.StarterPackage.$version.nupkg" -ApiKey $apiKey
}
