#!/bin/sh -x

OWNED_DIR=`pwd`

if [ -d $OWNED_DIR ]; then
    USRID=$(stat -c '%u' $OWNED_DIR)
    GRPID=$(stat -c '%g' $OWNED_DIR)

    grpent=`getent group $GRPID`
    if [ $? -ne 0 ]; then
        addgroup -g $GRPID dummy
        GRP_NAME=dummy
    else
        GRP_NAME=`echo $grpent | cut -d : -f 0`
    fi

    userent=`getent passwd $USRID`
    if [ $? -ne 0 ]; then
        adduser -D -G $GRP_NAME -u $USRID -s /bin/sh dummy
        USR_NAME=dummy
    else
        USR_NAME=`echo $userent | cut -d : -f 0`
    fi

    addgroup $USR_NAME wheel

    exec sudo -E -u $USR_NAME -g $GRP_NAME -s HOME=/home/dummy "$@"
fi

exec $@
