# AWS-EKS-CLUSTER-DEPLOY
Avant de lancer le script davay.sh, configurer kubectl :  
> aws eks update-kubeconfig --region \<region\> --name \<cluster\_name\>  
  
Et initialiser terraform (à exécuter dans le dossier terraform et terraform/alb) :  
> terraform init  

  
Lancer le fichier davay.sh pour déployer l'infrastructure  
Lancer le fichier ostanovka.sh pour supprimer l'infrastructure  
  
!! Attention : Pour lancer le script de suppression, il faut que le script de déploiment ait été lancé au moins une fois !!  
  
Changer les informations de l'infra dans le fichier variables.tf  

## Troubleshoot
- Se bloque parfois lors du lancement : relancer le script
- Pour l'instant, le lancement du déploiement via le script ne donne aucune information. Il est possible de lancer le déploiement à la main :
  - Aller dans le dossier terraform
  - Initialiser terraform : `terraform init`
  - Lancer le déploiement de la première partie de l'infrastructure (vpc,subnet,sg,rtb,cluster eks, node group) : `terraform apply`
  - À la fin du déploiement, des informations sont renvoyées : prefix, region et subnets utilisés. Ces informations seront nécessaires pour déployer la deuxième partie de l'infra
  - Lancer le déploiement de la deuxième partie (load balancer) : Aller dans le dossier terraform/alb, initialiser terraform (`terraform init`), et lancer le déploiement avec les infos récupérées : `terraform apply -auto-approve -var "prefix=monprefix" -var "region=eu-west-1" -var "subnet_ids=subnet-xxxx,subnet-xxxx"`
