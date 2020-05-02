# automount-ecryptfs
Mount/umount an eCryptfs filesystem automatically on user login/logout.
Works only on Gnome based systems due to dependency on Gnome Session Manager for logout detection.

## Description
The purpose of automount-ecryptfs is to automatically mount/umount ecryptfs encrypted secondary filesystems. I.e. the security depends on having these configuration scripts stored in a primary filesystem which is already encrypted, e.g. an encrypted home directory. The reason is that the ecryptfs passphrase is stored in cleartext...       

Currently, these tools assume that the ecryptfs filesystem has already been created and that the passphrase is available. 

The tools create the following files, where \<conf_id\> is an identifier chosen by the user during initial configuration:

| File | Comment |
| ---- | ------- |
| ~/.automount-\<conf_id\>.conf | Contains the configuration metadata; e.g.mount locations |
| ~/.automount-\<conf_id\>.ecryptfs | Maintains the ecryptfs passphrase separately for easy parsing |
| ~/automount-\<conf_id\>.sh | The script executed by the Startup Applications functionality |
| ~/.config/autostart/automount-\<conf_id\>.desktop | Programmatically adding an application to Startup Applications |
| /etc/sudoers.d/01_automount-\<conf-id\> | Allow unattended execution of restricted commands, e.g. mount/umount |

## Usage
### Initial configuration
`$ ./configure`

### Removal of configuration files
`$ ./configure -d <conf_id>`

## Supported Platforms
All Gnome based systems should be supported. Verified on:
* Ubuntu 14.10 through to 17.04
