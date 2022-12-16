#! /bin/sh

# Pre-check tools ( git, npm )

pm2 --version > /dev/null 2>&1
PM2_IS_AVAILABLE=$?
if [ "$PM2_IS_AVAILABLE" -ne "0" ]
then
    echo "Installing pm2..."
    npm install -g pm2
fi

pm2 delete all
cd "cargowork/"

echo ""
echo "[Step 1/3] Running backend service"
cd "wms-service/"
git pull
pm2 start "yarn dev" --name wms_service --time --no-autorestart
cd ".."

echo ""
echo "[Step 2/3] Running graph service"
cd "know_graph_service/"
git pull
pm2 start "yarn dev" --name know_graph_service --time --no-autorestart
cd ".."

echo ""
echo "[Step 3/3] Running frontend service"
cd "wms-aotga/"
git pull
pm2 start "yarn start" --name wms-aotga --time --no-autorestart
cd ".."

pm2 monit