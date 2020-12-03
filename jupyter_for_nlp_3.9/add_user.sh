#!/bin/bash
for TMP in $JUPYTER_USERS;
    do
        useradd $TMP
    done
