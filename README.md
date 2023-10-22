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

5. **Utiliza la API**: Una vez que la infraestructura esté desplegada puedes enviar un GET al endpoint https://9jam985kpl.execute-api.us-west-2.amazonaws.com/default/hd-lambda-function2 

## Contribuir

Si deseas contribuir a este proyecto, por favor, haz un fork del repositorio y crea una pull request. Asegúrate de seguir las mejores prácticas de desarrollo y de incluir tests para cualquier funcionalidad nueva.


```
HTTP/1.1 200 OK

Date=Sun, 22 Oct 2023 06:25:11 GMT

Content-Type=text/plain; charset=utf-8

Content-Length=1175

Connection=keep-alive

Apigw-Requestid=NML7LjL5vHcESyg=



{"passenger_id": {"0": 1, "1": 2, "2": 3, "3": 4, "4": 5, "5": 6, "6": 7, "7": 8, "8": 9, "9": 10, "10": 11, "11": 12, "12": 13, "13": 14, "14": 15, "15": 16, "16": 17, "17": 18, "18": 19, "19": 20}, "flight_id": {"0": 1001, "1": 1002, "2": 1003, "3": 1004, "4": 1005, "5": 1006, "6": 1007, "7": 1008, "8": 1009, "9": 1010, "10": 1011, "11": 1012, "12": 1013, "13": 1014, "14": 1015, "15": 1016, "16": 1017, "17": 1018, "18": 1019, "19": 1020}, "name": {"0": "Juan Perez", "1": "Maria Rodriguez", "2": "Pedro Gonzalez", "3": "Lucia Fernandez", "4": "Ricardo Lopez", "5": "Sofia Torres", "6": "Gabriel Ramirez", "7": "Carmen Morales", "8": "Rafael Medina", "9": "Laura Ortega", "10": "Eduardo Castro", "11": "Teresa Guzman", "12": "Javier Pe\u00f1a", "13": "Susana Rios", "14": "Fernando Reyes", "15": "Rosa Mendoza", "16": "Gustavo Silva", "17": "Marta Romero", "18": "Luis Cordero", "19": "Alicia Delgado"}, "seat_number": {"0": "12A", "1": "12B", "2": "15A", "3": "15B", "4": "16A", "5": "16B", "6": "17A", "7": "17B", "8": "18A", "9": "18B", "10": "19A", "11": "19B", "12": "20A", "13": "20B", "14": "21A", "15": "21B", "16": "22A", "17": "22B", "18": "23A", "19": "23B"}}
```

## Warning: 
El comando `set-output` está deprecado https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

## Post-data
Me hubiese gustado continuar con la ingesta mediante PUSH, usar SNS para activar el Pub/Sub, crear el Diagrama de la infraestructura con LucidCharts, en un punto ya tenia el Dockerfile buildeado y cargado a ECR pero volví a usar el código python sobre lambda.

En un ambiente empresarial usaría EKS, con sus respectivos liveness y readiness check, con sus test de integración, recopilando datos con Prometheus, comprimiendolos y trabajándolos con Grafana Mimir o Thanos, además de Obviamente el entorno Gráfico de Grafana. usando terraform workspaces para separar los ambientes, develop, qa, stagging y prod, con sus respectivas variables a lo largo del código, estandarizando los nombres de los objetos con prefijos y sufijos, usár más variables y más modulos, además de las practicas GitOps de la mano de ArgoCD, sería genial.

Así mismo Grafana tiene para alertar y establecer un on-call, además si escaláramos la solucion a 50 sistemas similares, se nos permitiría desbloquear nuevas métricas y formas de visualización. Por ejemplo, podríamos agregar métricas que muestren el rendimiento promedio de todos los sistemas y mostrarlas en un dashboard de Grafana, o el número de sistemas que están experimentando problemas También podríamos usar gráficos de líneas para mostrar tendencias a lo largo del tiempo.

En caso conrtrario, si no abordamos correctamente el problema de escalabilidad, podríamos enfrentar varias dificultades y limitaciones a nivel de observabilidad de los sistemas. Por ejemplo, si simplemente agregamos más paneles de control para cada sistema adicional, podría ser MUY difícil mantener una visión general de todos los sistemas. También podríamos enfrentar problemas con el rendimiento y la latencia de prometheus si nuestra solución de observabilidad no puede manejar la carga adicional. Además, si no configuramos correctamente las alertas y umbrales, podríamos terminar con una gran cantidad de falsos positivos o falsos negativos. con sus respectivas consecuencias.


# Gracias por la oportunidad