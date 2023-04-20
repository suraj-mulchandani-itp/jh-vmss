Write-Host "Script Start!"
Set-ExecutionPolicy Bypass -Scope Process
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install kubernetes-cli kubernetes-helm azure-cli git -y

#Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
#.\install-docker-ce.ps1 -NoRestart

Invoke-WebRequest 'https://dot.net/v1/dotnet-install.ps1' -OutFile 'dotnet-install.ps1'
.\dotnet-install.ps1 -InstallDir '~/.dotnet' -Version '6.0.0' -Runtime 'dotnet'

Invoke-WebRequest "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-Windows-x86_64.exe"  -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe

Write-Host "Script End!"