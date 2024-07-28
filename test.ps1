if (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
    Write-Output "sqlcmd command exists."
}
else {
    Write-Output "sqlcmd command does not exist."
    exit 1
}

Write-Output "Checking if SQL Server is available ..."
& sqlcmd -S 127.0.0.1 -U sa -P $env:SA_PASSWORD -Q "SELECT 1"

Write-Output "Check if requested version was installed ..."
$sqlcmdOutput = & sqlcmd -S 127.0.0.1 -U sa -P $env:SA_PASSWORD -Q "SELECT @@VERSION" -h -1
$result = $sqlcmdOutput | Select-String -Pattern "Microsoft SQL Server (\d+)"

if ($result.Matches.Groups[1].Value -Eq $env:VERSION) {
    Write-Output "Installled version matches expected version $env:VERSION"
}
else {
    Write-Error "Installed version does not match expected version $env:VERSION"
    Write-Error "sqlcmd output: $sqlcmdOutput"
    exit 1
}

Write-Output "Check status of connection encryption ..."

$sqlQuery = @"
SELECT 
session_id,
encrypt_option
FROM sys.dm_exec_connections
WHERE session_id = @@SPID;
"@

$results = sqlcmd -S 127.0.0.1 -U sa -P $env:SA_PASSWORD -Q $sqlQuery -h -1 -W

if ($env:FORCE_ENCRYPTION -eq "true") {
    if ($results -match "TRUE") {
        Write-Output "Connection from sqlcmd to the sqlengine appears to be encrypted, as expected!"
    }
    else {
        Write-Error "Connection to SQL server is not encrypted!"
        exit 1
    }
}
else {
    if ($results -match "TRUE") {
        Write-Error "Somehow the connection to the SQL server is encrypted, misconfiguration?"
        exit 1
    }
    else {
        Write-Output "Connection from sqlcmd to the sqlengine appears to not be encrypted, as expected!"
    }
}
