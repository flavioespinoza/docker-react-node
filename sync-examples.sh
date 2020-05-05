


if [ -z "$(git status --porcelain ./json-examples)" ]; then 
  echo "Working directory clean"
else 
  # construct branch_name
  timestamp=$(date +%s)

  branch_prefix=sync-examples

  branch_name="${branch_prefix}--${timestamp}"

  # directory in the project's root that contain the files you want to add to the remote_repo
  root_source_dir=json-examples

  # define a temp_source_dir called branch_name
  temp_source_dir=${branch_name}

  # define the remote_repo you will copy files into
  remote_repo=https://github.com/flavioespinoza/sync-docs.git

  # remove any existing temp_source_dir that starts with the branch_prefix
  rm -rf ${branch_prefix}*

  # clone the destination_repo into the project's root directory named temp_source_dir
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

  # commit changes with a message 
  git commit -m "${branch_name} to ${remote_repo}"

  # push files to track on remote_repo branch_name
  git push -u origin ${branch_name}

  # create a pull-request on remote_repo
  hub pull-request -h ${branch_name} -m "balls"

  # cd into the project's root directory
  cd ..

  # remove the temp_source_dir
  rm -rf ${temp_source_dir}

  # log success
  echo "Disco! :)"
fi