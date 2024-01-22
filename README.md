# ms-sqlserver-docker
Configures Microsoft's SQL server docker image with the correct default mount bindings for data and log files.

## Installation
Prior to building the image and creating the container, ensure the following:
- All Docker files are in the same directory.
- One has valid permissions to the (external) volumes they plan to mount to the container.
- Docker Compose is installed--included when using Docker Desktop.

## Usage
Simply run the following command in a terminal session that's mapped to the directory where the files have been cloned to build the image and create the container in detach mode. 
```linux
$ docker compose -f mssql-compose.yml up --build -d
```
- Use the `.env` file to edit yaml variables.
- By default the external port is set to `1001`; therefore change this port if one plans to run multiple containers in the same (local) network.
- One can use a different image tag for the `feature_tag_name` variable provided by Microsoft's Docker Hub repository found at this link: https://hub.docker.com/_/microsoft-mssql-server/
- Use the following file path syntax for mounting external volumes:
  - Windows - `"D:\\Path\\To\\Folder"`
  - Linux - `/mnt/d/path/to/folder`
- Connect Microsoft's SQL Server Management Studio to the *containerized* database with the following UI inputs:
  - **NOTE:**
    - `1001` is the (default) port number and thus one has to change that value if different than what's assigned to the `port_values` variable.
    - Password is what has been assigned to the variable, `MSSQL_SA_PASSWORD`. 
![image](https://github.com/GhostMach/ms-sqlserver-docker/assets/69784137/ec8a573a-4842-415a-a9a6-129214a10b61)


## Features
- Maps (4) seperate external volume bind mounts for the following directores:
  - User created database log files (`.ldf`).
  - User created database files (`.mdf`).
  - The default (`/var/opt/mssql/data`) location for system database and log files.
  - The default (`/var/backups`) location for database backups.
- **NOTE**: The user created database directory and its respective log file directory--for the MS SQL Server container--are created when the image is being built. 
- Automatically sets the default locations of these directory mounts in MS SQL Server's `.conf` file when building the (Docker) image.

## Etcetera
- Validated to work in Docker Desktop v4.26.1.
- Container runs with user `mssql` (non-root privelage) and the working directory is `/var/opt/mssql`.
  - To enter the running container as a root user, execute the following in a terminal:
    -  `$ docker exec -itu root container-name sh`
