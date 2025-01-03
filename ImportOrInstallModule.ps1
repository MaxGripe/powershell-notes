function Import-OrInstall-Module {
    param (
        [string]$ModuleName,
        [string]$RequiredVersion
    )
    try {
        Write-Host "Importing module: $ModuleName" -ForegroundColor Cyan
        Import-Module -Name $ModuleName -RequiredVersion $RequiredVersion -Force -ErrorAction Stop
        Write-Host "Successfully imported module: $ModuleName" -ForegroundColor Green
    }
    catch {
        Write-Host "Module $ModuleName not found or failed to import. Installing..." -ForegroundColor Yellow
        Install-Module -Name $ModuleName -Force -RequiredVersion $RequiredVersion -SkipPublisherCheck -AllowClobber
        Import-Module -Name $ModuleName -ErrorAction Stop
        Write-Host "Module $ModuleName installed and imported successfully." -ForegroundColor Green
    }
}

Import-OrInstall-Module -ModuleName "Pester" -RequiredVersion "4.10.0"
Import-OrInstall-Module -ModuleName "dbatools" -RequiredVersion "2.1.21"
Import-OrInstall-Module -ModuleName "DBAChecks" -RequiredVersion "2.0.18"

Write-Host "Module in use: Pester, Version: $((Get-Module -Name Pester).Version)"
Write-Host "Module in use: dbatools, Version: $((Get-Module -Name dbatools).Version)"
Write-Host "Module in use: DBAChecks, Version: $((Get-Module -Name DBAChecks).Version)"
