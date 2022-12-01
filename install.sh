#! /bin/bash

cat << EOF

**********************************
** VIM BY JIAJUN QUICK STARTUP  **
**********************************

EOF

if [ -e ~/.vimrc ]
then
	echo "backup vim configuration file"
	echo ">> .vimrc -> /tmp/.vimrc_backup"
	mv ~/.vimrc /tmp/.vimrc_backup
fi

cp .vimrc ~/
echo "updated vim configuration"
echo ">> copied newest .vimrc"

cat << EOF

************************************
** ENJOY VIM ! SUPPORT VIM SCRIPT **
************************************

EOF
