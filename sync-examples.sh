
# the root_source_dir contain the files you want to copy to the remote_repo
root_source_dir=json-examples

# check status change in root_source_dir
if [ -z "$(git status --porcelain ./${root_source_dir})" ]; then 
  # if NO status change do nothing and exit
  echo "Working directory clean"
  exit 1
else 
  # if YES status change do stuff
  echo "Changes to be commited"

  # construct a branch_name
  timestamp=$(date +%s)
  branch_prefix="sync-examples"
  branch_name="${branch_prefix}--${timestamp}"

  # define a temp_source_dir called branch_name
  temp_source_dir=${branch_name}

  # define the remote_repo you will copy files into
  remote_repo="https://github.com/flavioespinoza/sync-docs.git"

  # define a commit message
  commit_message="${branch_name} copied to ${remote_repo}"

  # remove any existing temp_source_dir that starts with the branch_prefix
  rm -rf ${branch_prefix}*

  # clone the destination_repo as temp_source_dir
  git clone ${remote_repo} ${temp_source_dir}

  # cd into the temp_source_dir
  cd ${temp_source_dir}

  # checkout a new branch called branch_name
  git checkout -b ${branch_name}

  # cd back into the project root directory
  cd ..

  # copy all files in the root_source_dir to the temp_source_dir
  cp -r ${root_source_dir} ${temp_source_dir}

  # cd into temp_source_dir
  cd ${temp_source_dir}

  # add changes to staging
  git add .

  # commit changes to branch_name with commit_message
  git commit -m ${commit_message}

  # push branch_name upstream to remote_repo
  git push -u origin ${branch_name}

  # create a pull-request on remote_repo
  hub pull-request -h ${branch_name} -m ${commit_message}

  # cd back into the project root directory
  cd ..

  # remove the temp_source_dir
  rm -rf ${temp_source_dir}

  # log success
  echo "Disco! ${commit_message} was successfull! :)"
fi