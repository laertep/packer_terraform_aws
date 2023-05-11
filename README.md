## Projeto packer_terraform_aws

** Projeto com intuito de balancear entre 02 instâncias aplicação CEP.HTML

* Pasta packer com arquivo json para provisionar uma AMI para subir uma aplicação html em 2 instâncias

* Pasta ansible provisiona o arquivo html com o arquivo plaubook.yml com as devidas configurações e roles

* Pasta terraform provisiona toda a estrutura das instâncias que irão absorver as configurações da AMI na pasta packer
