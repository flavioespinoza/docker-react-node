green='\033[32m'
end_green='\033[0m'
            
red='\033[31m'
end_red='\033[0m'
            
yellow='\033[33m'
end_yellow='\033[0m'
      
blue='\033[34m'  
end_blue='\033[0m'

cyan='\033[36m'
end_cyan='\033[0m'

# vars -------
timestamp=$(date +%s)


echo -e "${green}starting sync${end_green}"

# curl https://github.com/github/hub/releases/download/v2.14.2/hub-linux-386-2.14.2.tgz 

git clone https://github.com/github/hub.git

cd hub

make install

hub --version

# cd ..

# rm -rf tempest--*

# git clone https://github.com/flavioespinoza/sync-docs.git tempest--${timestamp}

# cp docker-react-node/helm tempest--${timestamp}

# cd tempest--${timestamp}

# git checkout -b tempest--${timestamp}

# git add .

# git commit 'Sync-Docs - Copy Examples'

# git push -u origin tempest--${timestamp}

# hub pull-request -m "Sync-Docs: tempest--${timestamp}"

# cd ..

# rm -rf tempest--${timestamp}

# echo -e "${green}sync complete${end_green}"

# if [ -z "$(git status --porcelain)" ]; then 
#   # Working directory clean
# else 
#   # Uncommitted changes
# fi