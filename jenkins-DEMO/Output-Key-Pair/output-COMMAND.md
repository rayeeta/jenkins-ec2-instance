##  1. If it is missing or incorrect, retrieve the private key again using:

### terraform output private_key_pem (copy and paste this line of command to output your private key)

Save the output to jenkinKey.pem.

## 2. Fix Permissions
Ensure the file has the correct permissions:

### chmod 600 jenkinKey.pem
