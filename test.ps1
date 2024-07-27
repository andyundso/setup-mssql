if (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
    Write-Output "sqlcmd command exists."
} else {
    Write-Output "sqlcmd command does not exist."
    exit 1
}
