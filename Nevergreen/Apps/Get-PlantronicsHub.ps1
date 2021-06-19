$Response = Invoke-WebRequest 'https://www.poly.com/gb/en/support/downloads-apps/hub-desktop' -DisableKeepAlive -UseBasicParsing
$URL32 = $Response.Links | Where-Object href -Like '*PlantronicsHubInstaller.exe*' | Select-Object -ExpandProperty href -First 1
$Version = ($Response.Content | Select-String -Pattern 'Version ((?:\d+\.)+\d+)').Matches.Groups.Value | Select-Object -Last 1

if ($Version -and $URL32) {

    $URL32 = Set-UriPrefix -Uri $URL32 -Prefix 'https://www.poly.com'

    [PSCustomObject]@{
        Version      = $Version
        Architecture = 'x86'
        URI          = $URL32
    }
}