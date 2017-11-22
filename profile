# ---
# Local machine stuff
# ---
export PATH="$HOME/.local/bin/_overlay:$PATH:$HOME/.local/bin"
export EDITOR=nvim
export TERM=xterm-256color
#export INPUTRC="$HOME/.config/inputrc"
export STARDICT_DATA_DIR="$HOME/Sync/dic"
export SDCV_PAGER="grcat $HOME/.config/grc/conf.sdcv | less -RFX"

# RC
export GTK_RC_FILES="$HOME/.config/gtk/gtkrc"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc"

export GIMP2_DIRECTORY="$HOME/.local/share/gimp-2.8"
export MPLAYER_HOME="$HOME/.config/mplayer"
export MPV_HOME="$HOME/.config/mpv"
export SciTE_HOME="$HOME/.config/scite"

export PYTHONSTARTUP="$HOME/.config/pythonrc.py"

# Wine
export WINEPREFIX=$HOME/.local/share/wine/
export WINEARCH=win32

# Go
export GOPATH=$HOME/Sync/projects/go
export PATH=$PATH:$GOPATH/bin

export WORKON_HOME="$HOME/.cache/python-envs"
