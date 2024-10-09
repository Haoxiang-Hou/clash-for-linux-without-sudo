#!/bin/bash
export HTTP_PROXY=http://127.0.0.1:7890
export HTTPS_PROXY=http://127.0.0.1:7890
export NO_PROXY=localhost,127.0.0.1
tmux new-session -d -s clash './bin/clash-linux-amd64 -d ./conf 2>&1 | tee -a ./logs/myclash.log'

