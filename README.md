# automount-ecryptfs
Mount/umount an eCryptfs filesystem automatically on user login/logout.
Works only on Gnome based systems due to dependency on Gnome Session Manager for logout detection.

##Description
The purpose of automount-ecryptfs is to automatically mount/umount ecryptfs encrypted secondary filesystems. I.e. the security depends on having these configuration scripts stored in a primary filesystem which is already encrypted, e.g. an encrypted home directory. The reason is that the ecryptfs passphrase is stored in cleartext...       

Currently, these tools assume that the ecryptfs filesystem has already been created and that the passphrase is available. 

##Usage
### Initial configuration
`$ ./configure`

### Removal of configuration files
`$ ./configure -d <configuration_id>`

##Supported Platforms
All Gnome based systems should be supported. Verified on:
* Ubuntu 14.10
