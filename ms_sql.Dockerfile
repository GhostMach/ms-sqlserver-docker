# Authored by: Adam H. Meadvin 
# Email: adam@medvyn.io
# GitHub: @GhostMach 
# Creation Date: 21 January 2024

ARG feature_tag

FROM mcr.microsoft.com/mssql/server:${feature_tag}
WORKDIR /var/opt/mssql
RUN mkdir dblog && mkdir dbdata
USER root
RUN /opt/mssql/bin/mssql-conf set filelocation.defaultdatadir /var/opt/mssql/dbdata && \
/opt/mssql/bin/mssql-conf set filelocation.defaultlogdir /var/opt/mssql/dblog && \
/opt/mssql/bin/mssql-conf set filelocation.defaultbackupdir /var/backups
USER mssql