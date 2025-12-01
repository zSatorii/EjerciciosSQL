# Códigos MySQL - Adaptados con Johan Castro

-- 1. Conexión a MySQL
mysql -h nombre_del_servidor -u johan_castro -p base_datos_johan

-- 2. Crear Base de Datos
CREATE DATABASE empleados_castro;

-- 3. Asignar Permisos
GRANT ALL ON empleados_castro.* 
TO johan_castro@localhost 
IDENTIFIED BY 'contrasena_segura_2024';

-- 4. Crear Tabla de Vendedores (adaptada a Johan Castro)
CREATE TABLE vendedores(
  numero_empleado INT,
  apellido VARCHAR(40),
  nombre_pila VARCHAR(30),
  comision TINYINT
);

-- 5. Inserción Individual de Registro
INSERT INTO vendedores 
VALUES
(1, 'Castro', 'Johan', 25);

-- 6. Inserción Múltiple de Registros
INSERT INTO vendedores 
VALUES
(1, 'Castro', 'Johan', 25),
(2, 'Mendez', 'Sofia', 18),
(3, 'Rodriguez', 'Carlos', 22);

-- 7. Cargar Datos desde Archivo
LOAD DATA LOCAL INFILE 'datos_vendedores.txt' 
INTO TABLE vendedores;

-- 8. Consulta Básica - Obtener Comisión
SELECT comision 
FROM vendedores 
WHERE apellido='Castro';

-- 9. Consulta con AND
SELECT * FROM vendedores 
WHERE apellido = 'Castro' 
AND comision > 20;

-- 10. Consulta con OR
SELECT * FROM vendedores 
WHERE nombre_pila = 'Johan' 
OR apellido = 'Castro';

-- 11. Búsqueda de Patrones - LIKE (Comienza con)
SELECT * FROM vendedores 
WHERE apellido LIKE 'Cast%';

-- 12. Búsqueda de Patrones - LIKE (Contiene)
SELECT * FROM vendedores 
WHERE nombre_pila LIKE '%an%';

-- 13. Búsqueda de Patrones - LIKE (Termina con)
SELECT * FROM vendedores 
WHERE apellido LIKE '%tro';

-- 14. Orden Ascendente
SELECT * FROM vendedores
ORDER BY apellido ASC, nombre_pila ASC;

-- 15. Orden Descendente por Comisión
SELECT * FROM vendedores
ORDER BY comision DESC;

-- 16. Limitar Resultados - Top 10
SELECT * FROM vendedores
LIMIT 10;

-- 17. Paginación - Segunda Página
SELECT * FROM vendedores
LIMIT 10, 10;

-- 18. Obtener Solo el Segundo Registro
SELECT * FROM vendedores
LIMIT 1, 1;

-- 19. Contar Registros
SELECT COUNT(*) as total_vendedores 
FROM vendedores;

-- 20. Valor Máximo y Mínimo
SELECT 
  MAX(comision) as comision_maxima,
  MIN(comision) as comision_minima
FROM vendedores;

-- 21. Promedio de Comisiones
SELECT AVG(comision) as promedio_comisiones 
FROM vendedores;

-- 22. Suma Total de Comisiones
SELECT SUM(comision) as total_comisiones 
FROM vendedores;

-- 23. Obtener Fecha Actual
SELECT NOW() as fecha_actual;

-- 24. Extraer Año, Mes, Día
SELECT 
  YEAR(CURDATE()) as ano,
  MONTH(CURDATE()) as mes,
  DAY(CURDATE()) as dia;

-- 25. Formatear Fecha
SELECT DATE_FORMAT(NOW(), '%W, %M %d, %Y') as fecha_formateada;

-- 26. Calcular Diferencia de Fechas
SELECT 
  nombre_pila,
  apellido,
  DATEDIFF(NOW(), fecha_ingreso) as dias_trabajando
FROM vendedores;

-- 27. Calcular Edad (con fecha de nacimiento)
SELECT 
  nombre_pila, 
  apellido,
  (YEAR(CURDATE()) - YEAR(fecha_nacimiento)) 
  - (RIGHT(CURDATE(),5) < RIGHT(fecha_nacimiento,5)) 
  AS edad 
FROM vendedores;

-- 28. Actualizar Registro
UPDATE vendedores 
SET comision = 28 
WHERE numero_empleado=1;

-- 29. Actualizar Múltiples Campos
UPDATE vendedores 
SET comision = 30, departamento = 'Ventas Premium'
WHERE apellido = 'Castro';

-- 30. Eliminar un Registro
DELETE FROM vendedores 
WHERE numero_empleado = 5;

-- 31. Eliminar Registros por Condición
DELETE FROM vendedores 
WHERE comision < 10;

-- 32. Agregar Columna a Tabla
ALTER TABLE vendedores 
ADD fecha_ingreso DATE;

-- 33. Agregar Múltiples Columnas
ALTER TABLE vendedores 
ADD fecha_ingreso DATE,
ADD telefono VARCHAR(15),
ADD email VARCHAR(50);

-- 34. Modificar Tipo de Columna
ALTER TABLE vendedores 
MODIFY comision INT;

-- 35. Renombrar y Modificar Columna
ALTER TABLE vendedores 
CHANGE comision porcentaje_comision DECIMAL(5,2);

-- 36. Eliminar Columna
ALTER TABLE vendedores 
DROP COLUMN departamento;

-- 37. Crear Tabla de Clientes
CREATE TABLE clientes(
  cliente_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_cliente VARCHAR(50),
  empresa VARCHAR(50),
  ciudad VARCHAR(30)
);

-- 38. Crear Tabla de Ventas
CREATE TABLE ventas(
  venta_id INT PRIMARY KEY AUTO_INCREMENT,
  numero_vendedor INT,
  cliente_id INT,
  monto DECIMAL(10,2),
  fecha_venta DATE,
  FOREIGN KEY (numero_vendedor) REFERENCES vendedores(numero_empleado),
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- 39. Insertar Clientes
INSERT INTO clientes(nombre_cliente, empresa, ciudad)
VALUES 
('Empresa A Colombia', 'Tech Solutions', 'Bogotá'),
('Empresa B Cali', 'Digital Services', 'Cali'),
('Empresa C Medellín', 'Innovation Hub', 'Medellín');

-- 40. Insertar Ventas
INSERT INTO ventas(numero_vendedor, cliente_id, monto, fecha_venta)
VALUES 
(1, 1, 5000000, '2024-01-15'),
(1, 2, 3500000, '2024-01-20'),
(2, 1, 2000000, '2024-02-01'),
(3, 3, 7500000, '2024-02-10');

-- 41. JOIN - Combinación Básica
SELECT 
  v.nombre_pila, 
  v.apellido, 
  ven.monto
FROM vendedores v, ventas ven
WHERE ven.numero_vendedor = v.numero_empleado
  AND v.nombre_pila='Johan' 
  AND v.apellido='Castro';

-- 42. INNER JOIN - Explícito
SELECT 
  v.nombre_pila,
  v.apellido,
  c.nombre_cliente,
  ven.monto
FROM vendedores v
INNER JOIN ventas ven ON v.numero_empleado = ven.numero_vendedor
INNER JOIN clientes c ON ven.cliente_id = c.cliente_id
WHERE v.apellido = 'Castro';

-- 43. LEFT JOIN - Todos los Vendedores y sus Ventas
SELECT 
  v.nombre_pila,
  v.apellido,
  COUNT(ven.venta_id) as total_ventas
FROM vendedores v
LEFT JOIN ventas ven ON v.numero_empleado = ven.numero_vendedor
GROUP BY v.numero_empleado
ORDER BY total_ventas DESC;

-- 44. Agrupar Resultados - GROUP BY
SELECT 
  numero_vendedor,
  SUM(monto) AS total_ventas
FROM ventas
GROUP BY numero_vendedor
ORDER BY total_ventas DESC;

-- 45. GROUP BY con HAVING
SELECT 
  numero_vendedor,
  SUM(monto) AS total_ventas
FROM ventas
GROUP BY numero_vendedor
HAVING SUM(monto) > 3000000
ORDER BY total_ventas DESC;

-- 46. Crear Tabla con Tipos Numéricos
CREATE TABLE productos(
  producto_id TINYINT,
  codigo_producto SMALLINT,
  inventario MEDIUMINT,
  precio INT,
  cantidad_vendida BIGINT
);

-- 47. Crear Tabla con UNSIGNED
CREATE TABLE contadores(
  contador_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  cantidad INT UNSIGNED
);

-- 48. Crear Tabla con ZEROFILL
CREATE TABLE facturas(
  numero_factura INT(6) ZEROFILL PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  monto DECIMAL(10,2)
);

-- 49. Crear Tabla con ENUM
CREATE TABLE usuarios(
  usuario_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  genero ENUM('Masculino','Femenino','Otro'),
  estado ENUM('Activo','Inactivo','Suspendido')
);

-- 50. Crear Tabla con SET
CREATE TABLE empleados_habilidades(
  empleado_id INT,
  nombre VARCHAR(50),
  habilidades SET('MySQL','PHP','JavaScript','Python','Java'),
  PRIMARY KEY(empleado_id)
);

-- 51. Insertar con ENUM
INSERT INTO usuarios(nombre, genero, estado)
VALUES ('Johan Castro', 'Masculino', 'Activo');

-- 52. Insertar con SET
INSERT INTO empleados_habilidades(empleado_id, nombre, habilidades)
VALUES (1, 'Johan Castro', 'MySQL,PHP,Python');

-- 53. Crear Tabla con DATE
CREATE TABLE eventos(
  evento_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_evento VARCHAR(100),
  fecha_evento DATE,
  hora_evento TIME,
  fecha_hora DATETIME
);

-- 54. Crear Tabla con TIMESTAMP
CREATE TABLE cambios_datos(
  cambio_id INT PRIMARY KEY AUTO_INCREMENT,
  descripcion VARCHAR(200),
  fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 55. Insertar Eventos
INSERT INTO eventos(nombre_evento, fecha_evento, hora_evento, fecha_hora)
VALUES 
('Reunión con Johan Castro', '2024-03-15', '14:30:00', '2024-03-15 14:30:00'),
('Capacitación de Ventas', '2024-03-20', '09:00:00', '2024-03-20 09:00:00');

-- 56. Formatear Fechas Específicas
SELECT 
  DATE_FORMAT(fecha_evento, '%d/%m/%Y') as fecha_española,
  DATE_FORMAT(fecha_evento, '%m-%d-%Y') as fecha_usa,
  DATE_FORMAT(fecha_evento, '%W, %M %d, %Y') as fecha_completa
FROM eventos;

-- 57. Crear Índice
CREATE INDEX idx_apellido_vendedor ON vendedores(apellido);

-- 58. Crear Índice Compuesto
CREATE INDEX idx_apellido_nombre ON vendedores(apellido, nombre_pila);

-- 59. Crear Índice Único
CREATE UNIQUE INDEX idx_email_usuario ON usuarios(email);

-- 60. Ver Información de Índices
SHOW INDEX FROM vendedores;

-- 61. Analizar Consulta con EXPLAIN
EXPLAIN SELECT * FROM vendedores 
WHERE apellido = 'Castro';

-- 62. Transacción Básica
START TRANSACTION;
UPDATE vendedores SET comision = 35 WHERE numero_empleado = 1;
UPDATE vendedores SET comision = 30 WHERE numero_empleado = 2;
COMMIT;

-- 63. Transacción con ROLLBACK
START TRANSACTION;
UPDATE ventas SET monto = 1000000 WHERE venta_id = 1;
ROLLBACK;

-- 64. Crear Usuario
CREATE USER 'johan_desarrollador'@'localhost' 
IDENTIFIED BY 'contraseña_segura_2024';

-- 65. Otorgar Permisos SELECT
GRANT SELECT ON empleados_castro.* 
TO 'johan_desarrollador'@'localhost';

-- 66. Otorgar Permisos INSERT y UPDATE
GRANT INSERT, UPDATE ON empleados_castro.vendedores
TO 'johan_desarrollador'@'localhost';

-- 67. Otorgar Todos los Permisos
GRANT ALL PRIVILEGES ON empleados_castro.* 
TO 'johan_admin'@'localhost';

-- 68. Revocar Permisos
REVOKE INSERT, UPDATE ON empleados_castro.* 
FROM 'johan_desarrollador'@'localhost';

-- 69. Cambiar Contraseña de Usuario
ALTER USER 'johan_castro'@'localhost' 
IDENTIFIED BY 'nueva_contraseña_2024';

-- 70. Eliminar Usuario
DROP USER 'johan_desarrollador'@'localhost';

-- 71. Respaldar Base de Datos (mysqldump)
mysqldump -u johan_castro -p empleados_castro > respaldo_2024.sql

-- 72. Restaurar Base de Datos
mysql -u johan_castro -p empleados_castro < respaldo_2024.sql

-- 73. Respaldar Tabla Específica
mysqldump -u johan_castro -p empleados_castro vendedores > vendedores_backup.sql

-- 74. Respaldar con Compresión
mysqldump -u johan_castro -p empleados_castro | gzip > respaldo_comprimido.sql.gz

-- 75. Crear Vista
CREATE VIEW vendedores_comisiones_altas AS
SELECT 
  nombre_pila,
  apellido,
  comision
FROM vendedores
WHERE comision > 20;

-- 76. Ver Vista
SELECT * FROM vendedores_comisiones_altas;

-- 77. Crear Vista con Agregación
CREATE VIEW resumen_ventas_por_vendedor AS
SELECT 
  v.nombre_pila,
  v.apellido,
  COUNT(ven.venta_id) as total_operaciones,
  SUM(ven.monto) as monto_total,
  AVG(ven.monto) as monto_promedio
FROM vendedores v
LEFT JOIN ventas ven ON v.numero_empleado = ven.numero_vendedor
GROUP BY v.numero_empleado;

-- 78. Subconsulta - Empleados con Comisión Mayor al Promedio
SELECT nombre_pila, apellido, comision
FROM vendedores
WHERE comision > (
  SELECT AVG(comision) 
  FROM vendedores
);

-- 79. Subconsulta con IN
SELECT nombre_cliente
FROM clientes
WHERE cliente_id IN (
  SELECT cliente_id 
  FROM ventas 
  WHERE monto > 2000000
);

-- 80. Subconsulta con EXISTS
SELECT nombre_pila, apellido
FROM vendedores v
WHERE EXISTS (
  SELECT 1 FROM ventas ven
  WHERE ven.numero_vendedor = v.numero_empleado
  AND ven.monto > 5000000
);

-- 81. UNION - Combinar Resultados
SELECT nombre_pila as nombre, 'Vendedor' as tipo 
FROM vendedores
UNION
SELECT nombre_cliente as nombre, 'Cliente' as tipo 
FROM clientes
ORDER BY nombre;

-- 82. UNION ALL - Mantener Duplicados
SELECT nombre_pila as nombre FROM vendedores
UNION ALL
SELECT nombre_cliente as nombre FROM clientes;

-- 83. Función IF
SELECT 
  nombre_pila,
  apellido,
  comision,
  IF(comision > 25, 'Alto', 'Normal') as nivel_comision
FROM vendedores;

-- 84. Expresión CASE
SELECT 
  nombre_pila,
  apellido,
  comision,
  CASE 
    WHEN comision > 30 THEN 'VIP'
    WHEN comision > 20 THEN 'Premium'
    ELSE 'Estándar'
  END as categoria
FROM vendedores;

-- 85. COALESCE - Manejo de NULLs
SELECT 
  nombre_pila,
  apellido,
  COALESCE(telefono, email, 'Sin contacto') as contacto
FROM vendedores;

-- 86. Funciones de Cadena - CONCAT
SELECT 
  CONCAT(nombre_pila, ' ', apellido) as nombre_completo
FROM vendedores;

-- 87. Funciones de Cadena - LENGTH
SELECT 
  nombre_pila,
  LENGTH(nombre_pila) as largo_nombre
FROM vendedores;

-- 88. Funciones de Cadena - UPPER y LOWER
SELECT 
  UPPER(nombre_pila) as nombre_mayuscula,
  LOWER(apellido) as apellido_minuscula
FROM vendedores;

-- 89. Funciones de Cadena - SUBSTRING
SELECT 
  SUBSTRING(nombre_pila, 1, 3) as iniciales
FROM vendedores;

-- 90. Funciones de Cadena - REPLACE
SELECT 
  REPLACE(nombre_pila, 'Johan', 'Juan') as nombre_modificado
FROM vendedores;

-- 91. Funciones de Cadena - TRIM
SELECT 
  TRIM(nombre_pila) as nombre_sin_espacios
FROM vendedores;

-- 92. Expresiones Regulares - REGEXP
SELECT * FROM vendedores
WHERE nombre_pila REGEXP '^J';

-- 93. Expresiones Regulares - Patrones Complejos
SELECT * FROM vendedores
WHERE apellido REGEXP '^[A-Z].*o$';

-- 94. Variable de Usuario - Suma Acumulativa
SET @total = 0;
SELECT 
  nombre_pila,
  apellido,
  monto,
  @total := @total + monto as suma_acumulativa
FROM ventas
ORDER BY venta_id;

-- 95. Variable de Usuario - Contador
SET @contador = 0;
SELECT 
  @contador := @contador + 1 as numero_fila,
  nombre_pila,
  apellido
FROM vendedores;

-- 96. Crear Procedimiento Almacenado
DELIMITER //
CREATE PROCEDURE ObtenerVentasPorVendedor(IN nombre_vendedor VARCHAR(30))
BEGIN
  SELECT * FROM ventas 
  WHERE numero_vendedor = (
    SELECT numero_empleado 
    FROM vendedores 
    WHERE nombre_pila = nombre_vendedor
  );
END //
DELIMITER ;

-- 97. Llamar Procedimiento Almacenado
CALL ObtenerVentasPorVendedor('Johan');

-- 98. Procedimiento con Parámetro OUT
DELIMITER //
CREATE PROCEDURE ObtenerTotalVentas(IN vendedor_id INT, OUT total DECIMAL(10,2))
BEGIN
  SELECT SUM(monto) INTO total 
  FROM ventas 
  WHERE numero_vendedor = vendedor_id;
END //
DELIMITER ;

-- 99. Llamar Procedimiento con OUT
CALL ObtenerTotalVentas(1, @total);
SELECT @total as total_ventas;

-- 100. Crear Trigger para Auditoría
DELIMITER //
CREATE TRIGGER auditoria_cambios_vendedor
AFTER UPDATE ON vendedores
FOR EACH ROW
BEGIN
  INSERT INTO auditoria(tabla, operacion, antiguo_valor, nuevo_valor, fecha)
  VALUES ('vendedores', 'UPDATE', OLD.comision, NEW.comision, NOW());
END //
DELIMITER ;

-- Consulta del perfil completo de Johan Castro
SELECT 
  numero_empleado,
  CONCAT(nombre_pila, ' ', apellido) as nombre_completo,
  comision as porcentaje_comision,
  COUNT(DISTINCT v.venta_id) as total_ventas_realizadas,
  SUM(v.monto) as monto_vendido_total,
  AVG(v.monto) as promedio_venta,
  MAX(v.monto) as venta_maxima,
  MIN(v.monto) as venta_minima
FROM vendedores ven
LEFT JOIN ventas v ON ven.numero_empleado = v.numero_vendedor
WHERE ven.nombre_pila = 'Johan'
GROUP BY ven.numero_empleado;