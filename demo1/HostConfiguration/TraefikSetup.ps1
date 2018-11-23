$TraefikHome = "C:\Traefik"
$TraefikRelease = "v1.7.4"


# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-Not (Test-Path $TraefikHome)) {
    mkdir $TraefikHome
}

if (-Not (Test-Path "$TraefikHome\traefik.exe"))
{
    Invoke-WebRequest "https://github.com/containous/traefik/releases/download/$TraefikRelease/traefik_windows-amd64.exe" -OutFile "$TraefikHome\traefik.exe"
}
Copy-Item traefik-helpers\traefik.toml $TraefikHome\


# Download NSSM
$NssmHome = "C:\nssm"
if (-Not (Test-Path $NssmHome)) {
    mkdir $NssmHome
}

$NssmRelease = "2.24"
if (-Not (Test-Path "$NssmHome\nssm.zip"))
{
    Invoke-WebRequest "https://nssm.cc/release/nssm-$NssmRelease.zip" -OutFile "$NssmHome\nssm.zip"
    Expand-Archive -LiteralPath "$NssmHome\nssm.zip" -DestinationPath $NssmHome
    Remove-Item $NssmHome\nssm.zip
}


# Install Traefik as a service
$nssm = "$NssmHome\nssm-$NssmRelease\win64\nssm.exe"
& $nssm install traefik "$TraefikHome\traefik.exe"
& $nssm set traefik AppDirectory $TraefikHome
& $nssm set traefik AppParameters  -c ".\traefik.toml"

mkdir C:\log
& $nssm set traefik AppStdout C:\log\traefik-stdout.log
& $nssm set traefik AppStderr C:\log\traefik-stderr.log
