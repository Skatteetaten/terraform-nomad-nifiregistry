# NiFi Registry with GIT version control integration

This example deploys a NiFi Registry container with git integration. 
Before running the example, some variables must be set beforehand. 

| Variable   | Default value | Description |
| ------------- | ------------- | ------------- |
| `git_remote_url`  | (empty)  | URL of the remote git repository. Must be HTTPS |
| `git_checkout_branch`  | (empty)  |Branch to checkout and track. If none is specified, repository is only cloned and no branch switching is done.|
| `git_flow_storage_directory`  | /opt/nifi-registry/flow-storage  | Default value is set by image, original default value was "./flow-storage". This variable is used in clone script as a destination directory for clone. It is also used in NiFi Registry configuration.|
| `git_remote_to_push`  | origin  |This variable is used in clone script to set origin name using `-o, --origin <name> use <name> instead of 'origin' to track upstream`. It is also used in NiFi Registry configuration.|
| `git_access_user`  | (empty)  |username|
| `git_access_password`  | (empty)  |password|
| `git_user_name`  | nifi-registry  |Developer|
| `git_user_email`  | nifi-registry@localhost  |Developer email|

These variables above __must be set directly in the example [main.tf](main.tf#L26-L33)__
