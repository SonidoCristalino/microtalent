# Proyecto de Infraestructura AWS con Terraform y EKS

## Resumen del Proyecto

Este repositorio contiene el código fuente para el aprovisionamiento de una infraestructura completa en Amazon Web Services (AWS) utilizando Terraform. El proyecto despliega una aplicación contenedorizada con Docker sobre un clúster de Amazon Elastic Kubernetes Service (EKS), respaldada por una base de datos gestionada Amazon RDS. La finalidad es demostrar un flujo de trabajo de Infraestructura como Código (IaC) para crear un entorno cloud-nativo, seguro y reproducible.

---

## Prerrequisitos

Para desplegar y gestionar esta infraestructura, es necesario tener instaladas y configuradas las siguientes herramientas en el sistema local:

* **AWS CLI:** La Interfaz de Línea de Comandos de AWS.
* **Terraform:** Versión 1.0 o superior.
* **kubectl:** La herramienta de línea de comandos de Kubernetes.

---

## Artefacto de la Aplicación

La imagen de Docker utilizada en este proyecto se encuentra publicada en un repositorio público en Docker Hub y puede ser accedida en el siguiente enlace:

[sonidocristalino/microtalent en Docker Hub](https://hub.docker.com/r/sonidocristalino/microtalent)

---

## Guía Rápida de Uso

A continuación, se presentan los comandos esenciales para la gestión del ciclo de vida del entorno.

### Creación del Entorno

1.  **Configuración de Variables Secretas**
    
    Antes de ejecutar el despliegue, es mandatorio configurar las variables. Copie el archivo de ejemplo `infra/terraform.tfvars.example` a un nuevo archivo llamado `infra/terraform.tfvars` y reemplace los valores placeholders.
    
    ```bash
    # Desde la raíz del proyecto, copie el archivo de ejemplo
    cp infra/terraform.tfvars.example infra/terraform.tfvars
    
    # Edite el archivo infra/terraform.tfvars con su editor de preferencia
    # y establezca una contraseña para la base de datos.
    ```

2.  **Aprovisionar la Infraestructura de AWS**
    
    ```bash
    # Navegue al directorio de la infraestructura
    cd infra/
    
    # Inicialice Terraform y aplique la configuración
    terraform init
    terraform apply
    ```

3.  **Configurar `kubectl`**
    
    Utilice el comando de salida proporcionado por Terraform después de ejecutar `apply` para conectar `kubectl` al nuevo clúster.
    
    ```bash
    aws eks --region us-east-1 update-kubeconfig --name microtalent-eks-cluster
    ```

4.  **Desplegar la Aplicación en EKS**
    
    Asegúrese de haber creado el `Secret` de Kubernetes como se detalla en la documentación completa (`Informe.pdf`).
    
    ```bash
    # Regrese al directorio raíz
    cd ..

    # Aplique los manifiestos de Kubernetes
    kubectl apply -f kubernetes/
    ```

### Destrucción del Entorno

Para eliminar todos los recursos y evitar costos en la cuenta de AWS, ejecute los siguientes comandos en orden:

1.  **Eliminar la Aplicación del Clúster**
    ```bash
    kubectl delete -f kubernetes/
    ```

2.  **Destruir la Infraestructura de AWS**
    ```bash
    cd infra/
    terraform destroy
    ```

---

## Documentación Completa

La documentación técnica detallada, incluyendo la justificación de la arquitectura, la implementación paso a paso y las conclusiones, se encuentra en el siguiente archivo:

> `MicroTalent/docs/Informe.pdf`

Dentro de este documento se puede encontrar la siguiente información clave:
* El **enunciado completo** del desafío se encuentra en la sección de **Apéndice**.
* La respuesta a cada uno de los ítems de la sección de **Notas** del desafío se encuentra detallada en el capítulo **"Conclusión y Cumplimiento de Requisitos"**.