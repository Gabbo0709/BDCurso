DROP DATABASE IF EXISTS db_gimnasio;
CREATE DATABASE db_gimnasio;

USE db_gimnasio;

-- Tabla que almacena la informacion de las sucursales
CREATE TABLE sucursal(
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    sucursal VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    apertura TIME NOT NULL,
    cierre TIME NOT NULL,
    telefono VARCHAR(10) NOT NULL
);

-- Tabla que almacena la informacion de los usuarios
CREATE TABLE usuario(
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    contresenia VARCHAR(50) NOT NULL
);

-- Tabla que almacena la informacion de los tipos de empleados
CREATE TABLE tipo_empleado(
    id_tipo_empleado INT AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(50) NOT NULL,
    detalle_cargo VARCHAR(100) NOT NULL
);

-- Tabla que almacena la informacion de los empleados
CREATE TABLE empleado(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_empleado INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_contratacion DATE NOT NULL,
    FOREIGN KEY (id_tipo_empleado) REFERENCES tipo_empleado(id_tipo_empleado),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla que almacena la informacion de los sueldos
CREATE TABLE sueldo (
    id_sueldo INT AUTO_INCREMENT PRIMARY KEY,
    sueldo DECIMAL(5,2) NOT NULL,
    id_tipo_empleado INT NOT NULL,
    FOREIGN KEY (id_tipo_empleado) REFERENCES tipo_empleado(id_tipo_empleado)
);

-- Tabla que almacena la informacion de las horas trabajadas por los empleados
CREATE TABLE horas_trabajadas (
    id_horas_trabajadas INT AUTO_INCREMENT PRIMARY KEY,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    id_empleado INT NOT NULL,
    total_mes INT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Tabla que almacena la informacion de la nomina de los empleados
CREATE TABLE nomina (
    id_nomina INT AUTO_INCREMENT PRIMARY KEY,
    id_sueldo INT NOT NULL,
    id_empleado INT NOT NULL,
    id_horas_trabajadas INT NOT NULL,
    total DECIMAL(5,2) NOT NULL,
    fecha_nomina DATE NOT NULL,
    FOREIGN KEY (id_sueldo) REFERENCES sueldo(id_sueldo),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_horas_trabajadas) REFERENCES horas_trabajadas(id_horas_trabajadas)
);

-- Tabla que almacena la informacion de las promociones
CREATE TABLE promocion(
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    inicio_proma DATE NOT NULL,
    fin_promo DATE NOT NULL,
    descuento DECIMAL(2,2) NOT NULL
);

-- Tabla que almacena la informacion de las suscripciones
CREATE TABLE suscripcion(
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_promocion INT DEFAULT 0,
    nombre VARCHAR(50) NOT NULL,
    costo_base DECIMAL(4,2) NOT NULL,
    detalle_suscripcion VARCHAR(100) NOT NULL,
    costo_total DECIMAL(4, 2) NOT NULL,
    fecha_suscripcion DATE NOT NULL,
    FOREIGN KEY (id_promocion) REFERENCES promocion(id_promocion)
);

-- Tabla que almacena la informacion de los productos
CREATE TABLE producto(
    id_producto VARCHAR(100) PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    costo DECIMAL(4, 2),
    detalle_producto VARCHAR(60)
);

-- Tabla que almacena la informacion del inventario de los productos
CREATE TABLE inventario(
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto VARCHAR(100) NOT NULL,
    id_sucursal INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Tabla que almacena la informacion de los clientes
CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_suscripcion INT NOT NULL,
    estado_suscripcion BOOLEAN NOT NULL DEFAULT 0,
    vigencia_suscripcion DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_suscripcion) REFERENCES suscripcion(id_suscripcion)
);

-- Tabla que almacena la informacion de los equipos
CREATE TABLE equipo(
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    descripcion_equipo VARCHAR(100) NOT NULL
);

-- Tabla que almacena la informacion de los detalles de las suscripciones
CREATE TABLE detalles_suscripcion (
    id_detalles_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_suscripcion INT NOT NULL,
    id_equipo INT NOT NULL,
    FOREIGN KEY (id_suscripcion) REFERENCES suscripcion(id_suscripcion),
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

-- Tabla que almacena la informacion de los horarios de las clases
CREATE TABLE horario_clase (
    id_horario_clase INT AUTO_INCREMENT PRIMARY KEY,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL
);

-- Tabla que almacena la informacion de las clases
CREATE TABLE clase(
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    costo DECIMAL(4, 2) NOT NULL
);

-- Tabla que almacena la informacion de los detalles de las clases
CREATE TABLE detalles_clase (
    id_detalles_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_clase INT NOT NULL,
    id_horario_clase INT NOT NULL,
    id_sucursal INT NOT NULL,
    FOREIGN KEY (id_clase) REFERENCES clase(id_clase),
    FOREIGN KEY (id_horario_clase) REFERENCES horario_clase(id_horario_clase),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

