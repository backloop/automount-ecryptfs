#!/bin/bash -x

# 
# Copyright (c) 2015 Pablo Cases, 
# Distributed under the MIT License.
# (See accompanying file LICENSE file or 
# copy at http://opensource.org/licenses/MIT)
# 

if (( $# !=2 )); then
    echo "Usage: $0 <automount-config-file> <automount-passphrase-file>"
    exit 1
fi

conffile=$1
if ! [ -f $conffile ]; then
    echo "Configuration file '$conffile' cannot be found. Abort."
    exit 1
fi
. $conffile

if ! [ -d $encrypt_path ]; then
    echo "Encrypted source path does not exist. Abort."
    exit 1
fi

if ! [ -d $decrypt_path ]; then
    echo "Decrypted source path does not exist. Abort."
    exit 1
fi

ecryptfs_passphrase_file=$2
if ! [ -f $ecryptfs_passphrase_file ]; then
    echo "Password file '$ecryptfs_passphrase_file' cannot be found. Abort."
    exit 1
fi

# execute "sudo ecryptfs-add-passphrase --fnek" before each mount to store in the kernel_keyring and avoid storing signatures in the sig-cache.txt. Used together with the no_sig_cache, ecryptfs_unlink_sigs options
. $ecryptfs_passphrase_file
authtokens=($(sudo ecryptfs-add-passphrase --fnek <<< $passwd | grep -o "[0-9a-f]\{16\}"))
if (( ${#authtokens[@]} != 2 )); then
    echo "Output of ecryptfs-add-passphrase not as expected. Abort."
    exit 1
fi
ecryptfs_sig=${authtokens[0]}
ecryptfs_fnek_sig=${authtokens[1]}

sudo mount -t ecryptfs $encrypt_path $decrypt_path -o key=passphrase:passphrase_passwd_file=$ecryptfs_passphrase_file,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=y,no_sig_cache,ecryptfs_unlink_sigs,ecryptfs_sig=$ecryptfs_sig,ecryptfs_fnek_sig=$ecryptfs_fnek_sig,verbose
