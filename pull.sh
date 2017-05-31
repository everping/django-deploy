#!/bin/bash

SRC_PATH="/home/user/project/src/"
USERNAME="user"

echo "[+] Pulling..."

cd $SRC_PATH
sudo git checkout master
sudo git pull

echo "[+] Pull done"

echo "[+] setting permission"
sudo chown $USERNAME:$USERNAME -R $SRC_PATH

echo "[+] Setup done"

echo "[+] Restarting gunicorn"

sudo systemctl daemon-reload
sudo systemctl restart gunicorn

echo "[+] Done"
