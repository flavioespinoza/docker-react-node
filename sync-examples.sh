
timestamp=$(date +%s)

rm -rf tempest--*

git clone https://github.com/flavioespinoza/sync-docs.git tempest--${timestamp}

cp docker-react-node/helm tempest--${timestamp}

cd tempest--${timestamp}

git checkout -b tempest--${timestamp}

git add .

git commit 'Sync-Docs - Copy Examples'

git push -u origin tempest--${timestamp}

hub pull-request -m "Sync-Docs: tempest--${timestamp}"

cd ..

rm -rf tempest--${timestamp}

# if [ -z "$(git status --porcelain)" ]; then 
#   # Working directory clean
# else 
#   # Uncommitted changes
# fi