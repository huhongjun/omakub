#!/bin/bash

# 定位：初次安装，安装和卸载，安装应用的配置，系统的初始配置
# 没有：日常运维如备份恢复
# 没有充分考虑arch
# 没有运维菜单

# wget -qO- https://omakub.org/install | bash

# ToDo:
# tmux htop
# remove snapd

<<EOF
vm-omakub: openssh-server,openwrt-107,apt-aliyun,sftp: sync
tmux ls
tmux kill -t oma-inst
tmux switch -t oma-inst
tmux rename -t OLD NEW
    ^b  s-切换会话,o-下一个,z-窗格最大化
        %-左右,"-上下,Ctrl|Alt[<-边界左移,>-边界右移]
        ?-快捷键列表,$-修改会话名称,d-解绑会话返回shell
EOF

ssh -t omakub tmux new -t oma-inst -s oma-inst # ^b+d, tmux new -s CUR, ^b+s
bash -init-file="" -C "source ~/.local/share/omakub/install.sh"

export OMAKUB_REF=master
export GIT_REPO="https://github.com/huhongjun/omakub.git"

rm -rf ~/.local/share/omakub

git clone ${GIT_REPO} ~/.local/share/omakub >/dev/null
cd ~/.local/share/omakub && git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
cd -

# Installation starting...
source ~/.local/share/omakub/install.sh
