# 🚀 Terraform AWS 3-Tier Secure Infrastructure

Infraestrutura segura e escalável na AWS utilizando Terraform.

## 📌 Arquitetura

Implementação de uma arquitetura 3-tier composta por:

- VPC customizada
- Subnets públicas e privadas em múltiplas AZs
- Internet Gateway
- NAT Gateway
- Security Groups segmentados
- EC2 em subnet privada
- Application Load Balancer (ALB)
- Target Group com Health Check
- Route Tables públicas e privadas

---

## 🏗️ Diagrama da Arquitetura

Internet  
   │  
   ▼  
Application Load Balancer (Public Subnets - us-east-2a/b)  
   │  
   ▼  
EC2 Backend (Private Subnet - us-east-2a)  
   │  
   ▼  
NAT Gateway (Public Subnet)  
   │  
   ▼  
Internet Gateway  

---

## 🔐 Segurança Implementada

- EC2 localizada em subnet privada
- Acesso externo apenas via ALB
- NAT Gateway para saída controlada
- Security Groups segmentados:
  - ALB: porta 80 pública
  - EC2: aceita tráfego apenas do ALB
- IAM Role com SSM para acesso seguro (sem SSH aberto)

---

## 🌎 Região

- us-east-2 (Ohio)

---

## 🧱 Estrutura do Projeto

terraform-aws-3tier-secure-infra/
│
├── providers.tf
├── versions.tf
├── network.tf
├── security-groups.tf
├── ec2-backend.tf
├── alb.tf
├── outputs.tf
└── locals.tf


---

## ⚙️ Como executar

```bash
terraform init
terraform plan
terraform apply

📈 Conceitos aplicados

Infrastructure as Code (IaC)

AWS Networking

Load Balancing

Alta Disponibilidade

Segurança em camadas

Terraform State Management

IAM Roles

NAT para isolamento de backend

👨‍💻 Autor

Murillo Santiago

