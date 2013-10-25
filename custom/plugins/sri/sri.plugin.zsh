#! /bin/zsh
# sri.zsh

# env
export PACKAGE_PATH=/opt/sri

################## alias #################
alias sync-be="rsync -avz --stats nvitovitch@kestrel:'/tmp/be*' /media/sf_hostshare"
alias sync-harris="rsync -avg --stats nvitovitch@kestrel:~/local/Harris /media/sf_hostshare"

