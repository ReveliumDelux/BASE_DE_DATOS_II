FROM mysql:8.0

# Variables de entorno
ENV MYSQL_ROOT_PASSWORD=admin123
ENV MYSQL_DATABASE=sistema_empresarial_servicios
ENV MYSQL_USER=dbuser
ENV MYSQL_PASSWORD=password123

# Puerto expuesto
EXPOSE 3306

# Copiar scripts de inicialización (opcional, se ejecutarán automáticamente)
# COPY ./init-scripts /docker-entrypoint-initdb.d/

# Comando por defecto (ya viene con MySQL)
CMD ["mysqld"]
