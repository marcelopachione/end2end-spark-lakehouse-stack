# Hive Metastore Docker Image

This repository provides a Docker image for running a standalone Hive Metastore service, using OpenJDK 8 and Hadoop 3.2.0.

## Features

* Based on openjdk:8-slim for a lightweight image.

* Includes Hadoop 3.2.0 for HDFS interaction.

* Supports S3a connectivity by adding the required AWS JARs.

* Installs Apache Hive Standalone Metastore 3.0.0.

* Bundles MySQL Connector 5.1.47 for database connectivity.

* Build Instructions

* To build the Docker image, use the following command:

## How to build the image?
```
cd /applications/trino/hive
```

```
docker build -t your-domain/hive-metastore .
```

## How to push the image?
```
docker push -t your-domain/hive-metastore
```


# Funcionamento do Hive com MinIO e Trino

Para integrar o Hive com MinIO e o Trino, precisamos configurar o ambiente adequadamente. O Hive será responsável por armazenar os metadados, enquanto o MinIO será a fonte dos dados, e o Trino irá consultar as tabelas via Hive.

## 1. Banco de Dados Relacional (MariaDB) para Metadados

Primeiro, precisamos configurar um banco de dados relacional para armazenar os metadados do Hive. No nosso caso, utilizamos o MariaDB. O banco de dados será criado com o nome do container de `metastore-db`.

## 2. Criação do Esquema do Metastore

Em seguida, é necessário inicializar o esquema do Hive no MariaDB. O container `create-metastore-schema`, que depende do banco `metastore-db`, irá fazer a associação entre a imagem do Hive e o banco de dados, executando o seguinte comando:

```bash
command: /opt/hive-metastore/bin/schematool --verbose -initSchema -dbType mysql -userName ${MYSQL_ROOT_USER} -passWord ${MYSQL_ROOT_PASSWORD} -url jdbc:mysql://metastore-db:3306/metastore_db?createDatabaseIfNotExist=true
```

## 3. Configuração do Hive (Core e Metastore)

O Hive precisa ser configurado com dois arquivos principais: `core-site.xml` e `metastore-site.xml`. Esses arquivos estão localizados na pasta `metastore/trino` do nosso projeto. A configuração inclui os parâmetros necessários para conectar o Hive ao MinIO, utilizando o protocolo S3 da AWS.

## 4. Trino e Integração com Delta Tables via Hive

O Trino irá utilizar o Hive para consultar as tabelas Delta. Isso permite que o Trino acesse as tabelas armazenadas no MinIO via o Hive, que gerencia os metadados dessas tabelas.
