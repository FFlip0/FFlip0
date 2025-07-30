#oh-my-posh
  #oh-my-posh init pwsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/emodipt-extend.omp.json' | Invoke-Expression
  oh-my-posh init pwsh --config "C:\Users\user\ohmyposh-emodipt-extend.omp.json" | Invoke-Expression

#admin
  function a {Start-Process wezterm-gui -Verb RunAs}

#yazi
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
} 

cls
