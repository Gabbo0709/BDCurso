<?php
    $conexion = new mysqli("localhost", "root", "", "db_gimnasio");

    // Verificar la conexión
    if ($conexion->connect_error) {
        die("Error de conexión: " . $conexion->connect_error);

    }

    // Recibir los datos del formulario
    $sucursal = $_POST["sucursal"];
    $direccion = $_POST["direccion"];
    $contacto = $_POST["contacto"];
    $apertura = $_POST["apertura"]. ':00';
    $cierre = $_POST["cierre"] . ':00';
	
	echo "<script>alert('Sucursal: $sucursal . Dirección: $direccion . Contacto: $contacto . Apertura: $apertura . Cierre: $cierre')</script>";

    // Insertar los datos en la base de datos
    $sql = "INSERT INTO sucursal (sucursal, direccion, apertura, cierre, telefono) VALUES ('$sucursal', '$direccion', '$apertura', '$cierre', '$contacto')";
    if ($conexion->query($sql) === TRUE) {
        echo "<script>alert('Registro guardado correctamente');</script>";
    } else {
        echo "<script>alert(\Error al insertar el registro: " . $conexion->error . "');</script>";
    }

    // Cerrar la conexión con la base de datos
    $conexion->close();
?>
