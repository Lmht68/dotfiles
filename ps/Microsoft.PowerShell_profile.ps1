$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

Import-Module posh-git
Import-Module Terminal-Icons
Import-Module PSReadLine

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\theme.omp.json" | Invoke-Expression

function workon ($env) {
    & $env:WORKON_HOME\$env\Scripts\activate.ps1
}

function Load-MSVC {
    cmd /c '"C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 && set' |
    ForEach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            Set-Item -Path Env:$($matches[1]) -Value $matches[2]
        }
    }
}

function Check-ModuleUpdates {
    $modules = @(
        'posh-git',
        'Terminal-Icons',
        'PSReadLine'
    )

    foreach ($module in $modules) {
        $installed = Get-InstalledModule $module -ErrorAction SilentlyContinue
        $latest = Find-Module $module -ErrorAction SilentlyContinue

        if ($installed -and $latest) {
            if ($installed.Version -lt $latest.Version) {
                Write-Host "⬆ $module $($installed.Version) → $($latest.Version)" -ForegroundColor Yellow
            }
        }
    }

    # Check Oh My Posh (winget)
    $omp = winget upgrade --id JanDeDobbeleer.OhMyPosh --exact 2>$null

    if ($LASTEXITCODE -eq 0 -and $omp -match 'Available') {
        $line = $omp | Select-String 'JanDeDobbeleer\.OhMyPosh'

        if ($line) {
            $parts = ($line -replace '\s{2,}', ',').Split(',')

            if ($parts.Count -ge 4) {
                Write-Host "⬆ Oh My Posh $($parts[2]) → $($parts[3])" -ForegroundColor Yellow
            }
            else {
                Write-Host "⬆ Oh My Posh has an update available." -ForegroundColor Yellow
            }
        }
    }
}