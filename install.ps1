param (
    [ValidateSet("sqlcmd")]
    [string[]]$Components
)

if ("sqlcmd" -in $Components) {
    if ($IsMacOS) {
        Write-Output "Installing sqlcmd tools"
        brew install sqlcmd
    }

    if ($IsLinux) {
        $osRelease = Get-Content -Path "/etc/os-release" | Out-String
        $osRelease -match 'VERSION_ID="(\d+\.\d+)"' | Out-Null
        $version = $matches[1]

        if ($version -eq "24.04") {
            # for maintenance reasons, sqlcmd has been removed from the runner image
            # but a dedicated build is also not yet available, so we are using the Ubuntu 22.04 build
            Write-Output "Installing sqlcmd tools"

            $DownloadPath = "/tmp/sqlcmd.deb"
            Invoke-WebRequest "https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/s/sqlcmd/sqlcmd_1.5.0-1_jammy_all.deb" -OutFile $DownloadPath
            & sudo dpkg -i $DownloadPath
            Remove-Item $DownloadPath
        }
    }

    # Linux and Windows runner already contain sqlclient tools
    Write-Output "sqlclient tools are installed"
}
