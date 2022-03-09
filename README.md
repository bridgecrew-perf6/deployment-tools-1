## Packerize.ps1
A script meant to be used with Packer that can automate the installation of *almost* any program. You only need to place all the installers in a directory and copy it to the host. Packerize.ps1 will:
1. Temporarily break IE so none of the installers can open manual files and hang the script 
2. Iterate and unzip any .zip or .7z archives
3. Iterate and run any .msi or .exe with a variety of silent switches 

## Configure-users
Simple script which prompts for a number of users to be created, then asks for a username/password for each. ALl users are created as Administrators. 