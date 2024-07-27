if (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
    Write-Output "sqlcmd command exists."
}
else {
    Write-Output "sqlcmd command does not exist."
    exit 1
}

Write-Output "Checking if SQL Server is available ..."
& sqlcmd -S 127.0.0.1 -U sa -P $env:SA_PASSWORD -Q "SELECT 1"
