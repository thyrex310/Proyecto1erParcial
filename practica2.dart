import 'package:flutter/material.dart'; // Importa el paquete de Flutter para la interfaz gráfica.

// Define la clase Practica2 como un StatefulWidget porque su estado cambiará.
class Practica2 extends StatefulWidget {
  @override
  _Practica2State createState() => _Practica2State(); // Crea el estado de la pantalla.
}

// Estado de la clase Practica2.
class _Practica2State extends State<Practica2> {
  int _counter = 0; // Variable para almacenar el valor del contador.

  // Método para incrementar el contador.
  void _incrementCounter() {
    setState(() {
      _counter++; // Incrementa el contador en 1 y actualiza la UI.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 2: Contador de Clicks'), // Título en la barra de navegación.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos en la pantalla.
          children: <Widget>[
            Text(
              'Has hecho clic:', // Texto descriptivo para el contador.
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_counter', // Muestra el valor del contador.
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20), // Espaciado entre elementos.
            ElevatedButton(
              onPressed: _incrementCounter, // Llama al método que incrementa el contador.
              child: Text('Haz Clic'), // Texto del botón.
            ),
          ],
        ),
      ),
    );
  }
}
