import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para construir la interfaz gráfica.

// Importa los archivos de las diferentes prácticas para navegar entre ellas.
import 'screens/practica1.dart';
import 'screens/practica2.dart';
import 'screens/practica3.dart';
import 'screens/practica4.dart';
import 'screens/practica5.dart';
import 'screens/practica6.dart';

// Función principal que se ejecuta cuando inicia la aplicación.
void main() {
  runApp(MyApp()); // Llama a la clase MyApp para iniciar la aplicación.
}

// Clase principal de la aplicación que extiende StatelessWidget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prácticas Flutter', // Define el título de la aplicación.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Establece el tema de la aplicación con color azul.
      ),
      home: MainMenu(), // Define la pantalla principal de la aplicación como MainMenu.
    );
  }
}

// Clase MainMenu que representa la pantalla principal con un menú de opciones.
class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'), // Título que aparece en la barra de navegación superior.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente en la pantalla.
          children: <Widget>[
            // Botón para navegar a la pantalla de Práctica 1.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // Contexto de la aplicación necesario para la navegación.
                  MaterialPageRoute(builder: (context) => Practica1()), // Define la ruta para la pantalla de Práctica 1.
                );
              },
              child: Text('Práctica 1: Hola Mundo'), // Texto del botón.
            ),
            // Botón para navegar a la pantalla de Práctica 2.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // Contexto de la aplicación necesario para la navegación.
                  MaterialPageRoute(builder: (context) => Practica2()), // Define la ruta para la pantalla de Práctica 2.
                );
              },
              child: Text('Práctica 2: Contador de Clicks'), // Texto del botón.
            ),
            // Botón para navegar a la pantalla de Práctica 3.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // Contexto de la aplicación necesario para la navegación.
                  MaterialPageRoute(builder: (context) => Practica3()), // Define la ruta para la pantalla de Práctica 3.
                );
              },
              child: Text('Práctica 3: Contador con Temporizador'), // Texto del botón.
            ),
            // Botón para navegar a la pantalla de Práctica 4.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // Contexto de la aplicación necesario para la navegación.
                  MaterialPageRoute(builder: (context) => Practica4()), // Define la ruta para la pantalla de Práctica 4.
                );
              },
              child: Text('Práctica 4: Historial en Archivo de Texto'), // Texto del botón.
            ),
            // Botón para navegar a la pantalla de Práctica 5.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // Contexto de la aplicación necesario para la navegación.
                  MaterialPageRoute(builder: (context) => Practica5()), // Define la ruta para la pantalla de Práctica 5.
                );
              },
              child: Text('Práctica 5: Almacenamiento en SQLite'), // Texto del botón.
            ),
            // Botón para navegar a la pantalla de Práctica 6.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // Contexto de la aplicación necesario para la navegación.
                  MaterialPageRoute(builder: (context) => Practica6()), // Define la ruta para la pantalla de Práctica 6.
                );
              },
              child: Text('Práctica 6: Historial en SQLite'), // Texto del botón.
            ),
          ],
        ),
      ),
    );
  }
}
