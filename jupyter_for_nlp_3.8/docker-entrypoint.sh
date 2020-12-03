#!/bin/sh

# it builds start command
START_JUPYTER="jupyter notebook --ip $JUPYTER_HOST_IP --no-browser --NotebookApp.token=$JUPYTER_TOKEN"

# it runs start command
if [ $1 = 'start' ] ; then
    cd  $DATA_STORAGE_PATH
    $START_JUPYTER
else
    echo 'Set start mode in $1!'
    exit 1
fi
