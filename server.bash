### Create the user key on the client
ssh-keygen -f ~/.ssh/ssh_user -t ed25519 -C "SSH user key"

### Create the certificate authority key on the master 
### (in this case the server, but could be a third machine)
ssh-keygen -f ~/.ssh/ssh_ca -t ed25519 -I "SSH_CA_KEY_ID" -C "SSH CA key"

### Add the ssh_ca.pub to the authorized_keys on server
### Bummer, this dosn't work. Its not equal to the the 'TrustedUserCAKeys' option in the sshd_config
rm -r ~/.ssh/authorized_keys
cat ~/.ssh/ssh_ca.pub >> ~/.ssh/authorized_keys

### Sign the keys with the CA key
ssh-keygen -s ~/.ssh/ssh_ca -I ClientJOHL -n johl,root ~/.ssh/ssh_user.pub

# Inspect the certificate
ssh-keygen -Lf ~/.ssh/ssh_user-cert.pub 

# Set correct permissions
chown $USER -R ~/.ssh
chmod 755 /home/$USER
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/ssh_user
chmod 644 ~/.ssh/ssh_user.pub
chmod 644 ~/.ssh/ssh_user-cert.pub
chmod 600 ~/.ssh/ssh_ca
chmod 644 ~/.ssh/ssh_ca.pub

# Remove the not needed keys
# rm ~/.ssh/ssh_ca
# sudo cp ~/.ssh/ssh_ca.pub /etc/ssh/ssh_ca.pub

# Start the ssh server
sudo /usr/sbin/sshd -d -p 2222 -o TrustedUserCAKeys=/home/johl/.ssh/ssh_ca.pub -o PubkeyAuthentication=yes -o LogLevel=DEBUG3
    # or /etc/ssh/ssh_ca.pub to be more ssh correct 

# Alternative is to set the options in /etc/ssh/sshd_config set
#   PubkeyAuthentication yes
#   TrustedUserCAKeys /etc/ssh/ssh_ca.pub

# Not sure when to use the ssh-agent - not needed in ubuntu
#   Add the client key to the ssh-agent (client side)
#   ssh-add -D # To remove all logins
#   eval "$(ssh-agent -s)"
#   ssh-add ~/.ssh/ssh_user

# Configuration of a trusted host (not finished)
#   ssh-keygen -f ~/.ssh/ssh_host -t ed25519 -C "SSH host key"
#   ssh-keygen -s  ~/.ssh/ssh_ca -I HostJOHL -V +52w -h ~/.ssh/ssh_host.pub
#   sudo /usr/sbin/sshd -d -p 2222 -c ~/.ssh/ssh_host-cert.pub
