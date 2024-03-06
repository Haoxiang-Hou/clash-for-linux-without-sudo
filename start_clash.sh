#!/bin/bash
tmux new-session -d -s clash './bin/clash-linux-amd64 -d ./conf 2>&1 | tee -a ./logs/myclash.log'

