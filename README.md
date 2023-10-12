# AWS-EKS-CLUSTER-DEPLOY
Avant de lancer le script davay.sh, configurer kubectl :  
> aws eks update-kubeconfig --region \<region\> --name \<cluster\_name\>  
  
Lancer le fichier davay.sh pour déployer l'infrastructure  
Lancer le fichier ostanovka.sh pour supprimer l'infrastructure  
  
!! Attention : Pour lancer le script de suppression, il faut que le script de déploiment ait été lancé au moins une fois !!  
  
Changer les informations de l'infra dans le fichier variables.tf  
