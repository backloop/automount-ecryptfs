#!/bin/bash

# 
# Copyright (c) 2015 Pablo Cases, 
# Distributed under the MIT License.
# (See accompanying file LICENSE file or 
# copy at http://opensource.org/licenses/MIT)
# 

if (( $# != 1 )); then
    echo "Usage: $0 <automount-config-file>"
    exit 1
fi

conffile=$1
if ! [ -f $conffile ]; then
    echo "Configuration file '$conffile' cannot be found. Abort."
    exit 1
fi
. $conffile

# unattended thanks to conf in /etc/sudoers.d
sudo umount $decrypt_path
