#! /bin/sh

# Pre-check tools ( git, npm )
git --version > /dev/null 2>&1
GIT_IS_AVAILABLE=$?
if [ "$GIT_IS_AVAILABLE" -ne "0" ]
then
    echo "Please install git first."
    exit
fi

npm --version > /dev/null 2>&1
NPM_IS_AVAILABLE=$?
if [ "$NPM_IS_AVAILABLE" -ne "0" ]
then
    echo "Please install npm first."
    exit
fi

ENV_DECRYPT () {
    echo "Decrypting enc files"
    mkdir "env" > /dev/null 2>&1
    openssl enc -aes-256-cbc -d -in enc/wms-service.enc -out env/wms-service.env -pass file:wms-service/keys/development_rsa_4096_priv.pem
    openssl enc -aes-256-cbc -d -in enc/wms-aotga.enc -out env/wms-aotga.env -pass file:wms-service/keys/development_rsa_4096_priv.pem
    openssl enc -aes-256-cbc -d -in enc/know_graph_service.enc -out env/know_graph_service.env -pass file:wms-service/keys/development_rsa_4096_priv.pem
}

ECHO_AUTORUN() {
    echo '#! /bin/sh' > autorun.sh
    echo '' >> autorun.sh
    echo '# Pre-check tools ( git, npm )' >> autorun.sh
    echo '' >> autorun.sh
    echo 'pm2 --version > /dev/null 2>&1' >> autorun.sh
    echo 'PM2_IS_AVAILABLE=$?' >> autorun.sh
    echo 'if [ "$PM2_IS_AVAILABLE" -ne "0" ]' >> autorun.sh
    echo 'then' >> autorun.sh
    echo '    echo "Installing pm2..."' >> autorun.sh
    echo '    sudo npm install -g pm2' >> autorun.sh
    echo 'fi' >> autorun.sh
    echo '' >> autorun.sh
    echo 'pm2 delete all' >> autorun.sh
    echo 'cd ~/cargowork' >> autorun.sh
    echo '' >> autorun.sh
    echo 'echo ""' >> autorun.sh
    echo 'echo "[Step 1/3] Running backend service"' >> autorun.sh
    echo 'cd "wms-service/"' >> autorun.sh
    echo 'git pull' >> autorun.sh
    echo 'pm2 start "yarn dev" --name wms_service --time --no-autorestart' >> autorun.sh
    echo 'cd ".."' >> autorun.sh
    echo '' >> autorun.sh
    echo 'echo ""' >> autorun.sh
    echo 'echo "[Step 2/3] Running graph service"' >> autorun.sh
    echo 'cd "know_graph_service/"' >> autorun.sh
    echo 'git pull' >> autorun.sh
    echo 'pm2 start "yarn dev" --name know_graph_service --time --no-autorestart' >> autorun.sh
    echo 'cd ".."' >> autorun.sh
    echo '' >> autorun.sh
    echo 'echo ""' >> autorun.sh
    echo 'echo "[Step 3/3] Running frontend service"' >> autorun.sh
    echo 'cd "wms-aotga/"' >> autorun.sh
    echo 'git pull' >> autorun.sh
    echo 'pm2 start "yarn start" --name wms-aotga --time --no-autorestart' >> autorun.sh
    echo 'cd ".."' >> autorun.sh
    echo '' >> autorun.sh
    echo 'pm2 monit' >> autorun.sh
}

###
# Main body of script starts here
###
MAIN () {
    # User inputs
    read -p "[1/2] Enter bitbucket username: " BITBUCKET_USERNAME
    read -p "[2/2] Enter bitbucket App password: " BITBUCKET_PASSWORD

    # Install yarn if it doesn't exist
    yarn --version > /dev/null 2>&1
    YARN_IS_AVAILABLE=$?
    if [ "$YARN_IS_AVAILABLE" -ne "0" ]
    then
        echo "Installing yarn..."
        npm install --global yarn
    fi

    # Clone Backend Service
    echo "";
    echo "[Step 1] Start Cloning Backend Service"
    git clone "https://$BITBUCKET_USERNAME:$BITBUCKET_PASSWORD@bitbucket.org/knowledge-discovery/wms-service.git"
    IS_CLONE_BACKEND_SUCCESS=$?
    if [ "$IS_CLONE_BACKEND_SUCCESS" -eq "0" ] 
    then
        ENV_DECRYPT
        cd "wms-service/"
        cp ../env/wms-service.env ./.env
        yarn install
        cd "../"
    fi

    # Clone Know Graph Service
    echo "";
    echo "[Step 2] Start Cloning Know Graph Service"
    git clone "https://$BITBUCKET_USERNAME:$BITBUCKET_PASSWORD@bitbucket.org/knowledge-discovery/know_graph_service.git"
    IS_CLONE_GRAPH_SUCCESS=$?
    if [ "$IS_CLONE_GRAPH_SUCCESS" -eq "0" ] 
    then
        cd "know_graph_service/"
        cp ../env/know_graph_service.env ./.env
        yarn install
        cd "../"
    fi

    # Clone Frontend Service
    echo "";
    echo "[Step 3] Start Cloning Frontend Service"
    git clone "https://$BITBUCKET_USERNAME:$BITBUCKET_PASSWORD@bitbucket.org/knowledge-discovery/wms-aotga.git"
    IS_CLONE_FRONTEND_SUCCESS=$?
    if [ "$IS_CLONE_FRONTEND_SUCCESS" -eq "0" ] 
    then
        cd "wms-aotga/"
        cp ../env/wms-aotga.env ./.env
        git checkout dev-lated
        yarn install
        cd "../"
    fi

    ECHO_AUTORUN

    file wms-service/.env > /dev/null 2>&1
    BE_IS_INSTALLED=$?

    file know_graph_service/.env > /dev/null 2>&1
    GRAPH_IS_INSTALLED=$?

    file wms-aotga/.env > /dev/null 2>&1
    FE_IS_INSTALLED=$?

    [ "$BE_IS_INSTALLED" -eq "0" ] && [ "$GRAPH_IS_INSTALLED" -eq "0" ] && [ "$FE_IS_INSTALLED" -eq "0" ] && \
    rm cargowork_cloner.sh && \
    rm -rf enc && \
    rm -rf env
}
MAIN
