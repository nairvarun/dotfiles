# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Go path
if ! [[ "$PATH" =~ "/usr/local/go/bin:$HOME/go/bin:" ]]; then
    PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# if [ -d ~/.bashrc.d ]; then
#     for rc in ~/.bashrc.d/*; do
#         if [ -f "$rc" ]; then
#             . "$rc"
#         fi
#     done
# fi
# unset rc

# my config
if [ -f ~/.bashrc.d/config.sh ]; then
    . ~/.bashrc.d/config.sh
fi

. "$HOME/.cargo/env"
