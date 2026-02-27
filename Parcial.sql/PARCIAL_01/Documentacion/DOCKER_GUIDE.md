# GUÍA COMPLETA DE DOCKER PARA PARCIAL #1

## 📦 Requisitos Previos

- Docker instalado ([descargar](https://www.docker.com/products/docker-desktop))
- Docker Compose instalado (viene incluido en Docker Desktop)
- 2GB de espacio disco disponible
- Puertos 3306 y 8080 disponibles

---

## 🚀 OPCIÓN 1: Ejecutar con docker-compose (RECOMENDADO)

### 1.1 Iniciar los servicios

```bash
# Cambiar al directorio del proyecto
cd "c:\Users\User\OneDrive\Escritorio\UIP 2K26\Parcial.sql\PARCIAL_01"

# Levantar los servicios en modo detached (background)
docker-compose up -d

# Opcional: Ver logs en tiempo real
docker-compose logs -f mysql-db
```

**Salida esperada**:
```
Creating parcial-mysql ... done
Creating parcial-phpmyadmin ... done
```

---

### 1.2 Verificar que los servicios estén ejecutándose

```bash
# Listar contenedores en ejecución
docker-compose ps

# Salida esperada:
# NAME               COMMAND             STATUS              PORTS
# parcial-mysql      docker-entrypoint   Up 2 minutes       0.0.0.0:3306->3306/tcp
# parcial-phpmyadmin docker-php-entrypoin Up 2 minutes       0.0.0.0:8080->80/tcp
```

---

### 1.3 Conectar a la base de datos

**Opción A: Usar línea de comandos**
```bash
# Conectarse al contenedor MySQL
docker exec -it parcial-mysql mysql -u root -p

# Ingresar contraseña: admin123
```

**Opción B: Usar phpMyAdmin (interfaz gráfica)**
```
Abrir navegador → http://localhost:8080
Usuario: root
Contraseña: admin123
```

**Opción C: Usar cliente MySQL externo**
```
Host: localhost
Puerto: 3306
Usuario: root
Contraseña: admin123
```

---

### 1.4 Cargar Scripts SQL

**Opción A: Desde línea de comandos**
```bash
# Conectarse al contenedor
docker exec -it parcial-mysql mysql -u root -padmin123

# Dentro del contenedor MySQL:
USE sistema_empresarial_servicios;
SOURCE /ruta/a/02_DDL_CreateTables.sql;
SOURCE /ruta/a/03_DML_InsertDatos.sql;
```

**Opción B: Copiar archivos al contenedor y ejecutar**
```bash
# Copiar script al contenedor
docker cp Caso_1_Sistema_Empresarial/02_DDL_CreateTables.sql parcial-mysql:/tmp/

# Ejecutar en el contenedor
docker exec -it parcial-mysql mysql -u root -padmin123 < /tmp/02_DDL_CreateTables.sql
```

**Opción C: Usar phpMyAdmin**
- Conectarse a http://localhost:8080
- Seleccionar "SQL" en el menú
- Copiar y pegar contenido de archivo SQL
- Ejecutar

---

## 🔧 OPCIÓN 2: Ejecutar Comandos Docker Directos

### 2.1 Crear contenedor manualmente

```bash
# Crear y ejecutar contenedor MySQL
docker run -d \
  --name parcial-mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=admin123 \
  -e MYSQL_DATABASE=sistema_empresarial_servicios \
  -v mysql-data:/var/lib/mysql \
  mysql:8.0

# Explicación de flags:
# -d                           → Ejecutar en background
# --name parcial-mysql         → Nombre del contenedor
# -p 3306:3306                 → Puerto: local:contenedor
# -e MYSQL_ROOT_PASSWORD       → Variable de entorno (contraseña root)
# -e MYSQL_DATABASE            → Base de datos a crear
# -v mysql-data:/var/lib/mysql → Volumen persistente
# mysql:8.0                     → Imagen a usar
```

---

### 2.2 Verificar el estado del contenedor

```bash
# Ver contenedores activos
docker ps

# Ver todos los contenedores (incluyendo detenidos)
docker ps -a

# Ver logs del contenedor
docker logs parcial-mysql

# Ver logs en tiempo real
docker logs -f parcial-mysql

# Ver detalles del contenedor
docker inspect parcial-mysql
```

---

### 2.3 Conectar al contenedor

```bash
# Conectarse al shell del contenedor
docker exec -it parcial-mysql /bin/bash

# Dentro del contenedor, conectarse a MySQL
mysql -u root -padmin123

# Dentro de MySQL
SHOW DATABASES;
USE sistema_empresarial_servicios;
SHOW TABLES;
```

---

## 📊 OPCIÓN 3: Operaciones de Volúmenes y Persistencia

### 3.1 Gestionar volúmenes

```bash
# Listar volúmenes
docker volume ls

# Ver detalles de volumen
docker volume inspect mysql-data

# Eliminar volumen (CUIDADO: borra datos)
docker volume rm mysql-data
```

---

### 3.2 Hacer backup de la base de datos

```bash
# Backup completo de todas las bases de datos
docker exec parcial-mysql mysqldump -u root -padmin123 --all-databases > backup-completo.sql

# Backup de una base de datos específica
docker exec parcial-mysql mysqldump -u root -padmin123 sistema_empresarial_servicios > backup-empresarial.sql

# Backup de una tabla específica
docker exec parcial-mysql mysqldump -u root -padmin123 sistema_empresarial_servicios usuarios > backup-usuarios.sql
```

---

### 3.3 Restaurar desde backup

```bash
# Restaurar base de datos completa
docker exec -i parcial-mysql mysql -u root -padmin123 < backup-completo.sql

# Restaurar base de datos específica
cat backup-empresarial.sql | docker exec -i parcial-mysql mysql -u root -padmin123 sistema_empresarial_servicios
```

---

## 🛑 Detener y Limpiar

### 4.1 Con docker-compose

```bash
# Detener servicios (sin eliminar datos)
docker-compose stop

# Reiniciar servicios
docker-compose restart

# Detener y eliminar contenedores (datos en volumen persisten)
docker-compose down

# Detener, eliminar todo incluyendo volúmenes (BORRA DATOS)
docker-compose down -v
```

---

### 4.2 Con Docker directo

```bash
# Detener contenedor
docker stop parcial-mysql

# Reiniciar contenedor
docker restart parcial-mysql

# Eliminar contenedor
docker rm parcial-mysql

# Eliminar imagen
docker rmi mysql:8.0

# Limpiar sistema (elimina todo lo no utilizado)
docker system prune -a
```

---

## 🔍 Solución de Problemas

### Problema 1: Puerto 3306 ya en uso

**Síntoma**: Error "bind: address already in use"

**Soluciones**:
```bash
# Opción A: Cambiar puerto en docker-compose.yml
# Cambiar: ports: - "3307:3306"  (usar 3307 en lugar de 3306)

# Opción B: Matar proceso usando el puerto
# Windows:
netstat -ano | findstr :3306
taskkill /PID <PID> /F

# Linux/Mac:
lsof -i :3306
kill -9 <PID>
```

---

### Problema 2: MySQL no inicia correctamente

**Síntoma**: Contenedor se ve "Up" pero no responde

**Soluciones**:
```bash
# Ver logs detallados
docker logs parcial-mysql

# Esperar más tiempo (MySQL necesita inicializarse)
docker-compose up -d
sleep 30  # Esperar 30 segundos
docker exec -it parcial-mysql mysql -u root -padmin123 -e "SHOW DATABASES;"
```

---

### Problema 3: No se puede conectar desde cliente externo

**Síntoma**: Connection refused desde MySQL Workbench

**Verificaciones**:
```bash
# 1. Verificar que contenedor está corriendo
docker ps | grep mysql

# 2. Verificar que puerto 3306 está mapeado
docker port parcial-mysql

# 3. Verificar conectividad desde contenedor
docker exec -it parcial-mysql mysql -u root -padmin123 -h localhost

# 4. Prueba de conectividad desde host
telnet localhost 3306
```

---

## 📈 Comandos Útiles para Desarrollo

```bash
# Ver uso de recursos del contenedor
docker stats parcial-mysql

# Ejecutar comando dentro del contenedor
docker exec parcial-mysql ls -la /var/lib/mysql

# Copiar archivo del contenedor al host
docker cp parcial-mysql:/var/log/mysql/error.log ./mysql-error.log

# Copiar archivo del host al contenedor
docker cp ./mi-script.sql parcial-mysql:/tmp/

# Ver variables de entorno del contenedor
docker exec parcial-mysql env | grep MYSQL

# Cambiar credenciales (requiere recrear contenedor)
docker run -e MYSQL_ROOT_PASSWORD=nueva_contraseña ...
```

---

## 🔐 Seguridad en Docker

```bash
# NO HACER en producción:
# ❌ Contraseña visible en docker-compose.yml
# ❌ Usar imagen de alguien desconocido
# ❌ Exponer Puerto 3306 a internet (sin firewall)

# HACER:
# ✅ Usar variables de entorno desde archivo .env
# ✅ Usar imágenes oficiales
# ✅ Limitar acceso con firewall
# ✅ Usar HTTPS para phpMyAdmin
# ✅ Cambiar contraseña por defecto
```

---

## 📋 Resumen de Comandos Esenciales

| Comando | Descripción |
|---------|------------|
| `docker-compose up -d` | Levantar servicios |
| `docker-compose down` | Detener servicios |
| `docker-compose ps` | Ver estado |
| `docker-compose logs -f` | Ver logs |
| `docker exec -it parcial-mysql mysql -u root -p` | Conectarse |
| `docker ps` | Listar contenedores activos |
| `docker logs <container>` | Ver logs |
| `docker inspect <container>` | Detalles del contenedor |
| `docker volume ls` | Listar volúmenes |
| `docker system prune -a` | Limpiar todo |

---

## 🌐 Acceso a los Servicios

| Servicio | URL | Usuario | Contraseña |
|----------|-----|--------|-----------|
| MySQL CLI | `localhost:3306` | root | admin123 |
| MySQL (cliente externo) | `localhost:3306` | root | admin123 |
| phpMyAdmin | `http://localhost:8080` | root | admin123 |

---

## 📚 Referencias

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [MySQL Docker Hub](https://hub.docker.com/_/mysql)
- [phpMyAdmin Docker Hub](https://hub.docker.com/_/phpmyadmin)

---

**Última actualización**: Febrero 26, 2026  
**Versión**: 1.0
