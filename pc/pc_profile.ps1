function Initialize-Shell {
    $OMP_THEME_DIR = "$(scoop prefix oh-my-posh)\themes"
    $env:OMP_THEME = "powerlevel10k_rainbow.omp.json"
    if ($env:OMP_THEME) {
        $env:OMP_THEME = "$($env:OMP_THEME)"
    }
    else {
        [environment]::setEnvironmentVariable("OMP_THEME", $env:OMP_THEME, 'Machine')
    }
    oh-my-posh init pwsh --config "$($OMP_THEME_DIR)\$($env:OMP_THEME)" | Invoke-Expression
}
function Get-Comand-Source([string[]]$Command) {
    (Get-Command $Command).Source
}

# Alias configruation
New-Alias -Name which -Value Get-Comand-Source 

# Excute with shell starting
Initialize-Shell