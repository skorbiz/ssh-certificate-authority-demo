# ssh-certificate-authority-demo
Small bash script for a poc for setting up ssh with the certificate authority.

The aim has been to setup an ssh connection where both client and server is running on the same machine.

The goal has been to find all the quirks with ssh. Like file-permissions. A reproducable script to run.
And have a setup where where its somewhat convinient to debug. like starting with a known config and easy to see log.







## Inspiration links
- [linux audit](https://linux-audit.com/granting-temporary-access-to-servers-using-signed-ssh-keys/)
- [github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [redhat](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/deployment_guide/sec-using_openssh_certificate_authentication)
