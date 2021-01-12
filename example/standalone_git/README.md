# NiFi Registry with GIT version control integration

This example deploys a NiFi Registry container with git integration (Github). 
Before running the example, these variables must be set beforehand. 

| Variable   | Default value | Description |
| ------------- | ------------- | ------------- |
| `git_remote_url`  | " "  | URL of the remote git repository |
| `git_checkout_branch`  | " "  |Branch to checkout and track.|
| `git_flow_storage_directory`  | /opt/nifi-registry/flow-storage  | Default value is set by image, original default value was "./flow-storage". This variable is used in clone script as a destination directory for clone. It is also used in NiFi Registry configuration.|
| `git_remote_to_push`  | origin  |This variable is used in clone script to set origin name using `-o, --origin <name> use <name> instead of 'origin' to track upstream`. It is also used in NiFi Registry configuration.|
| `git_access_user`  | " "  |Username|
| `git_access_password`  | " "  |Password|
| `git_user_name`  | nifi-registry  |Developer|
| `git_user_email`  | nifi-registry@localhost  |Developer email|

__NOTE!__ In this version of the example, the variables above __must be written directly in the [main.tf](main.tf#L26-L33)__.
We are still improving this workflow to be more secure and agile.


![img](../resources/images/nifi_registry_git_integration.png)

Image: https://hub.docker.com/r/michalklempa/nifi-registry <br />
Source code: https://github.com/michalklempa/docker-nifi-registry/


