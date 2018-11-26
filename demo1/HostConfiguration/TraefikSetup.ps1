param(
     [string]$TraefikTomlPath,
     [string]$TraefikRulesTemplateTomlPath
)
# Example invocation:
# .\TraefikSetup.ps1 -TraefikTomlPath C:\data\traefik\traefik.toml -RulesTemplateTomlPath C:\data\traefik\rules.toml.template

$TraefikHome = "C:\Traefik"
$TraefikRelease = "v1.7.4"
$NssmHome = "C:\nssm"
$NssmRelease = "2.24"

if (-Not (Test-Path $TraefikTomlPath)) {
    throw "$TraefikTomlPath not found"
}

if (-Not (Test-Path $TraefikRulesTemplateTomlPath)) {
    throw "$TraefikRulesTemplateTomlPath not found"
}

# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


if (-Not (Test-Path $TraefikHome)) {
    mkdir $TraefikHome
}

if (-Not (Test-Path "$TraefikHome\traefik.exe"))
{
    Invoke-WebRequest "https://github.com/containous/traefik/releases/download/$TraefikRelease/traefik_windows-amd64.exe" -OutFile "$TraefikHome\traefik.exe"
}

Copy-Item $TraefikTomlPath $TraefikHome\traefik.toml -force
Copy-Item $TraefikRulesTemplateTomlPath $TraefikHome\rules.toml.template -force

# Download NSSM
if (-Not (Test-Path $NssmHome)) {
    mkdir $NssmHome
}

$nssm = "$NssmHome\nssm-$NssmRelease\win64\nssm.exe"
if (-Not (Test-Path $nssm))
{
    Invoke-WebRequest "https://nssm.cc/release/nssm-$NssmRelease.zip" -OutFile "$NssmHome\nssm.zip"
    Expand-Archive -LiteralPath "$NssmHome\nssm.zip" -DestinationPath $NssmHome
    Remove-Item $NssmHome\nssm.zip
}


# Install Traefik as a service

& $nssm install traefik "$TraefikHome\traefik.exe"
& $nssm set traefik AppDirectory $TraefikHome
& $nssm set traefik AppParameters  -c ".\traefik.toml" --debug
& $nssm set traefik Start SERVICE_AUTO_START

if (-Not (Test-Path "C:\log")) {
    mkdir C:\log
}
& $nssm set traefik AppStdout C:\log\traefik-stdout.log
& $nssm set traefik AppStderr C:\log\traefik-stderr.log

# Add nssm.exe to System Path
# https://codingbee.net/tutorials/powershell/powershell-make-a-permanent-change-to-the-path-environment-variable
$OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$NewPath = "$OldPath;$NssmHome\nssm-$NssmRelease\win64\"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath