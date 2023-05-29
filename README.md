## 🚀 Instancia EC2 t2.medium
#
#### Contiene:
- docker
- minikube
- kubectl

Esta instancia es para realizar practicas con docker y k8s
#
### Instrucciones de uso:

#### Requerimientos:
- [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
- [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [git](https://git-scm.com/)

Clonar este repositorio
```bash
git clone
```

Configurar nuestras credenciales de AWS, corremos el siguiente comando y pasamos aws_access_key_id y aws_secret_access_key
```bash
aws configure
```
Creamos nuestras llaves publicas y privadas
```bash
ssh-keygen -t rsa && cp ~/.ssh/id_rsa.pub .
```
👀 **En el archivo dev.tfvars le colocamos un nombre para identificar nuestra instancia**

Realizar el despliegue de la infraestructura con terraform
```bash
terraform init

terraform apply -var-file dev.tfvars -auto-approve
```
Con el siguiente comando ingresamos a nuestra instancia a trabajar, colocando la ip correspondiente obtenida en el output de terraform
```bash
ssh -i ~/.ssh/id_rsa ec2-user@IP_DE_INSTANCIA
```
Cuando ya no necesitemos nuestra infraestructura podemos eliminarla con terraform:
```bash
terraform destroy -var-file dev.tfvars -auto-approve
```
#
### 🎓 Buenas practicas!