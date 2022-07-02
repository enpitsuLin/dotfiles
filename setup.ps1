# setup scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

$env:SCOOP = 'E:\scoop' # custom scoop install dir
$env:SCOOP_GLOBAL = 'E:\scoop\apps' # custom scoop app install dir
[environment]::setEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
[environment]::setEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression

# add bucket and install unnecessary app

scoop install sudo

scoop bucket add dorado https://github.com/h404bi/dorado.git
scoop bucket add tomato https://github.com/zhoujin7/tomato.git
scoop bucket add extras
scoop bucket add nerd-fonts

sudo scoop install 7zip git openssh --global
scoop install aria2 curl grep touch
scoop install v2ray xray v2rayn
scoop install vscode
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json

# init git 
git config --global user.name "enpitsulin"
git config --global user.email "enpitsulin@gmail.com"

# get dotfiles
$Profile_Loctaion = Convert-Path ~
git clone git@github.com:enpitsuLin/dotfiles.git "$($Profile_Loctaion)/dotfiles"

# create symbolic link for pwsh profile
sudo New-Item -Path $profile -Value "$($Profile_Loctaion)/dotfiles/ps_profile.ps1" -ItemType SymbolicLink -Force