import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir la interfaz gráfica.

// Define la clase Practica1 que extiende StatelessWidget, ya que no tiene estado mutable.
class Practica1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 1: Hola Mundo'), // Establece el título de la barra de navegación superior.
      ),
      body: Center(
        child: Text('Hola Mundo'), // Muestra un texto centrado en la pantalla con el mensaje "Hola Mundo".
      ),
    );
  }
}