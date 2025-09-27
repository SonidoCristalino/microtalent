# Proyecto de Infraestructura AWS con Terraform y EKS

## Resumen del Proyecto

Este repositorio contiene el código fuente para el aprovisionamiento de una infraestructura completa en Amazon Web Services (AWS) utilizando Terraform. El proyecto despliega una aplicación contenedorizada con Docker sobre un clúster de Amazon Elastic Kubernetes Service (EKS), respaldada por una base de datos gestionada Amazon RDS. La finalidad es demostrar un flujo de trabajo de Infraestructura como Código (IaC) para crear un entorno cloud-nativo, seguro y reproducible.

---

## Documentación Completa

La documentación técnica detallada, incluyendo la justificación de la arquitectura, la implementación paso a paso y las conclusiones, se encuentra en el siguiente archivo:

> `MicroTalent/docs/Informe.pdf`

Dentro de este documento se puede encontrar la siguiente información clave:
* El **enunciado completo** del desafío se encuentra en la sección de **Apéndice**.
* La respuesta a cada uno de los ítems de la sección de **Notas** del desafío se encuentra detallada en el capítulo **"Conclusión y Cumplimiento de Requisitos"**.

---

## Guía Rápida de Uso

A continuación, se presentan los comandos esenciales para la gestión del ciclo de vida del entorno. Consulte la documentación completa para detalles sobre la configuración de variables y prerrequisitos.

### Creación del Entorno

Para desplegar la infraestructura completa, ejecute los siguientes comandos en orden:

1.  **Aprovisionar la infraestructura de AWS:**
    ```bash
    cd infra/
    terraform init
    terraform apply
    ```

2.  **Configurar `kubectl`:**
    *Utilice el comando de salida proporcionado por Terraform después de ejecutar `apply`.*
    ```bash
    aws eks --region us-east-1 update-kubeconfig --name microtalent-eks-cluster
    ```

3.  **Desplegar la aplicación en EKS:**
    *Asegúrese de haber creado el `Secret` de Kubernetes como se detalla en la documentación.*
    ```bash
    cd ..
    kubectl apply -f kubernetes/
    ```

### Destrucción del Entorno

Para eliminar todos los recursos y evitar costos en la cuenta de AWS, ejecute los siguientes comandos en orden:

1.  **Eliminar la aplicación del clúster:**
    ```bash
    kubectl delete -f kubernetes/
    ```

2.  **Destruir la infraestructura de AWS:**
    ```bash
    cd infra/
    terraform destroy
    ```