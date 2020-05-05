#!/bin/bash

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

# configured in the .drone.yml, and run when a pull-request is merged into master
cd ..
project_root_dir=${PWD}
echo -e "${cyan} project_root_dir=${project_root_dir} ${end_cyan}"

# the root_source_dir contains the files that will be copied to the remote_repo
root_source_dir="json-examples"

git_status="$(git status --porcelain ./${root_source_dir})"

# check change status of root_source_dir
if [ -z ${git_status} ]; then
  # if status NO changes do nothing and exit
  echo "Working directory clean"
  exit 1
else
  # if status YES changes do stuff
  echo "Changes to be commited"

  # nonce (ever increasing unique integer) used to construct the branch_name
  timestamp=$(date +%s)

  # construct the branch_name
  branch_prefix="sync"
  branch_name="${branch_prefix}--${timestamp}"

  # define the temp_source_dir which will contain the files that will be copied to the remote_repo
  # we set the temp_source_dir name equal to the branch_name to help clarify the flow as we move forward
  temp_source_dir=${branch_name}

  # define the remote_repo we will copy files to
  remote_repo="https://github.com/flavioespinoza/sync-docs.git"

  # define the commit_message
  commit_message=${branch_name}

  # remove any existing temp_source_dir whos name starts with the branch_prefix
  rm -rf ${branch_prefix}*

  # clone the destination_repo into the project root directory and change its name to temp_source_dir
  git clone $remote_repo $temp_source_dir

  # copy all files in the root_source_dir to the temp_source_dir
  cp -r $root_source_dir $temp_source_dir

  cp "${root_source_dir}/two.json" "${temp_source_dir}/json-examples/record-${timestamp}.txt"
  
  # cd into temp_source_dir
  echo -e "${cyan} cd into temp_source_dir ${end_cyan}"
  cd $temp_source_dir

  # checkout a new branch called branch_name
  git checkout -b ${branch_name}

  echo -e "${yellow} -- git status 1 -- ${end_yellow}"
  git status

  # add changes to staging
  git add .

  echo -e "${yellow} -- git status 2 -- ${end_yellow}"
  git status

  # commit changes to branch_name with commit_message
  git commit -m "${commit_message}."

  # push branch_name upstream to remote_repo
  git push -u origin $branch_name

  # create a pull-request on remote_repo
  hub pull-request  -m "${commit_message}." -h flavioespinoza:${branch_name}

  # cd back into the project root directory
  cd ..

  # remove the temp_source_dir
  rm -rf ${temp_source_dir}

  # log success
  echo "Sucess! ${commit_message} and a pull-request has been created! :)"
fi
