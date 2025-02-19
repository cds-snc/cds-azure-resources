#!/bin/zsh

touch /home/vscode/.zshrc 
echo 'complete -C /usr/local/bin/terraform terraform' >> /home/vscode/.zshrc 
echo 'complete -C /usr/local/bin/terraform terragrunt' >> /home/vscode/.zshrc 
echo 'alias tf=\"terraform\"' >> /home/vscode/.zshrc 
echo 'alias tg=\"terragrunt\"' >> /home/vscode/.zshrc 
echo 'alias ll=\"ls -la\"' >> /home/vscode/.zshrc

# Azure CLI login
az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID