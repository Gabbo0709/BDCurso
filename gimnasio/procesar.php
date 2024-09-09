<?php
    $conexion = new mysqli("localhost", "root", "", "gimnasio");

    // Verificar la conexión
    if ($conexion->connect_error) {
        die("Error de conexión: " . $conexion->connect_error);

    }

    // Recibir los datos del formulario
    $sucursal = $_POST["sucursal"];
    $direccion = $_POST["direccion"];
    $apertura = $_POST["apertura"];
    $cierre = $_POST["cierre"];

    // Insertar los datos en la base de datos
    $sql = "INSERT INTO sucursales (sucursal, direccion, apertura, cierre) VALUES ('$sucursal', '$direccion', '$apertura', '$cierre')";
    if ($conexion->query($sql) === TRUE) {
        echo "<script>alert('Registro guardado correctamente');</script>";
    } else {
        echo "<script>alert('Error al insertar el registro: " . $conexion->error . ");</script>";
    }

    // Cerrar la conexión con la base de datos
    $conexion->close();

    // Redireccionar a la página de inicio
    header("Location: index.php");
?>