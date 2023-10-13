# AWS-EKS-CLUSTER-DEPLOY
Avant de lancer le script terraform, configurer kubectl :  
> aws eks update-kubeconfig --region \<region\> --name \<cluster\_name\>  
  
Configurer terraform :  
> terraform init  

Lancer les commandes terraform dans l'ordre suivant :  
> terraform apply -target=module.base  
> terraform apply -target=module.eks\_cluster  
> terraform apply -target=module.node\_group  
> terraform apply -target=null\_resource.deploy  
> terraform apply -target=module.alb  
  
Changer les informations de l'infra dans le fichier variables.tf  
