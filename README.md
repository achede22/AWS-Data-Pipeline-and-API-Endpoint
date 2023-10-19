
Challenge DevSecOps/SRE

En este repositorio se muestra la infraestructura de un sistema para ingestar y almacenar datos en una DB con la finalidad de hacer analítica avanzada. Donde los datos almacenados son expuestos mediante una API HTTP para que puedan ser consumidos por terceros.

En las instrucciónes recibidas se solicita solicita utilizar una rama master y otra develop, sugiriendo Gitflow como práctica de desarrollo opcional, más GitFlow se considera un flujo de trabajo Git heredado o "legacy" que originalmente fue una estrategia disruptiva y novedosa para manejar las sucursales de Git. Sin Embargo Gitflow ha caído en popularidad a favor de los flujos de trabajo basados en troncos (trunk-based workflows), que actualmente se consideran mejores prácticas para el desarrollo de software continuo moderno y las prácticas de DevOps.

Si bien creé la rama master y develop como se solicitó, sugiero evaluar la práctica de desarrollo Trunk-based development.

# Trunk-based development:
https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development



Parte 1:Infraestructura e IaC

    Para lograr una infraestructura necesaria para ingestar, almacenar y exponer datos se necesita:
        - Amazon SNS (Simple Notification Service), que nos permite aplicar un esquema Pub/Sub.
        
        - Almacenamiento de Datos para Análisis: Si bien pudiéramos usar Amazon Redshift para hacer consultas analíticas complejas, se optó por recrear un pequeño DataLake en S3 y utilizar Athena para ejecutar consultas SQL sobre los datos almacenados en S3. por un tema de simplicidad y costos.

        - Exponer Datos: Si bien Amazon ofrece API Gateway para crear, publicar, mantener, monitorizar y proteger APIs REST, HTTP y WebSocket a cualquier escala. Al ser este un laboratorio decidí usar Lambda para crear una única función sencilla, ya que no necesito autorización con Cognito ni control de tráfico.

        Se incluye un módulo de IAM (Identity and Access MAnagement) para implementar las políticas de seguridad necesarias para permitir que Lambda publique en el tema SNS, que S3 permita el acceso a Athena, etc.
        
        Estoy usando la región us-west-2
     

