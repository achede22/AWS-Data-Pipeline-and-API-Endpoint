# Challenge DevSecOps/SRE

Este repositorio contiene la infraestructura de un sistema para ingestar y almacenar datos en una base de datos con el objetivo de realizar análisis avanzados. Los datos almacenados se exponen a través de una API HTTP para que puedan ser consumidos por terceros.

## Ramas y Flujo de Trabajo

Aunque se solicita utilizar una rama master y otra develop, sugerimos considerar el flujo de trabajo Trunk-based development como una práctica de desarrollo moderna y eficiente. Puedes encontrar más información sobre este flujo de trabajo en este enlace.

## Infraestructura e IaC

La infraestructura necesaria para ingerir, almacenar y exponer datos incluye:

- **Amazon SNS (Simple Notification Service)**: Permite aplicar un esquema Pub/Sub.
- **Almacenamiento de Datos para Análisis**: Aunque podríamos usar Amazon Redshift para realizar consultas analíticas complejas, hemos optado por crear un pequeño DataLake en S3 y utilizar Athena para ejecutar consultas SQL sobre los datos almacenados en S3. Esto se debe a razones de simplicidad y costos.
- **Exposición de Datos**: Aunque Amazon ofrece API Gateway para crear, publicar, mantener, monitorizar y proteger APIs a cualquier escala, hemos decidido usar Lambda para crear una única función sencilla en este laboratorio, ya que no necesitamos autorización con Cognito ni control de tráfico.

Además, se incluye un módulo de IAM (Identity and Access Management) para gestionar los permisos necesarios.

        
Estoy usando la región us-west-2

Como creé algunos elementos a mano en la consola, luego tuve que importarlos al tfstate de terraform:
        terraform import module.athena.aws_athena_database.challenge hdbucketchallenge
        terraform import module.lambda.aws_iam_role.challenge hd-lambda-function_execution_role
        terraform import module.s3.aws_s3_bucket.challenge hdbucketchallenge
        terraform import module.lambda.aws_lambda_function.challenge hd-lambda-function
        terraform import module.lambda.aws_lambda_permission.challenge hd-lambda-function/hd-lambda-function_AllowExecutionFromSNS

Continuando con el Paso #2 decidí:
    2.1 creé una aplicación Flask en Python que consulta datos a través de Athena y devuelva los resultados. 
    Luego, usé AWS API Gateway para crear un endpoint HTTP que maneje las solicitudes GET a la aplicación Flask.

        

## Cómo usar

Para utilizar este sistema, sigue estos pasos:

1. **Configura tu entorno AWS**: Asegúrate de tener una cuenta de AWS y de haber configurado tus credenciales de AWS en tu entorno local. Puedes hacer esto utilizando el comando `aws configure` del AWS CLI.

2. **Clona este repositorio**: Puedes clonar este repositorio utilizando el comando `git clone`.

3. **Instala las dependencias**: Este proyecto utiliza varias bibliotecas de Python,  utiliza el comando `pip install -r requirements.txt` para instalarlas.

4. **Despliega la infraestructura**: Puedes desplegar la infraestructura utilizando el comando `terraform apply`. Asegúrate de estar en el directorio correcto cuando ejecutes este comando.

5. **Utiliza la API**: Una vez que la infraestructura esté desplegada.

## Contribuir

Si deseas contribuir a este proyecto, por favor, haz un fork del repositorio y crea una pull request. Asegúrate de seguir las mejores prácticas de desarrollo y de incluir tests para cualquier funcionalidad nueva.

## Warning: 
The `set-output` command is deprecated and will be disabled soon. Please upgrade to using Environment Files. For more information see: https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/


# Gracias por la oportunidad