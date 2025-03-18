import 'package:flutter/material.dart'; // Importa el paquete de Flutter para la interfaz gráfica.
import 'dart:async'; // Importa la librería para manejar temporizadores.

// Define la clase Practica3 como un StatefulWidget porque su estado cambiará.
class Practica3 extends StatefulWidget {
  @override
  _Practica3State createState() => _Practica3State(); // Crea el estado de la pantalla.
}

// Estado de la clase Practica3.
class _Practica3State extends State<Practica3> {
  int _counter = 0; // Contador de clics.
  bool _isRunning = false; // Indica si el temporizador está activo.
  int _timeLeft = 10; // Tiempo inicial del temporizador en segundos.
  Timer? _timer; // Variable para almacenar el temporizador.

  // Método para iniciar el temporizador.
  void _startTimer() {
    if (_isRunning) return; // Si el temporizador ya está corriendo, no hacer nada.

    setState(() {
      _isRunning = true; // Marca que el temporizador ha comenzado.
      _timeLeft = 10; // Reinicia el tiempo restante.
      _counter = 0; // Reinicia el contador de clics.
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--; // Disminuye el tiempo restante en 1 segundo.
        } else {
          _isRunning = false; // Detiene el temporizador.
          timer.cancel(); // Cancela el temporizador.
          _showDialog(); // Muestra el diálogo con el resultado.
        }
      });
    });
  }

  // Método para incrementar el contador de clics si el temporizador está activo.
  void _incrementCounter() {
    if (_isRunning) {
      setState(() {
        _counter++; // Incrementa el contador.
      });
    }
  }

  // Método para mostrar un cuadro de diálogo cuando el tiempo se acabe.
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Temporizador Finalizado'), // Título del diálogo.
          content: Text('Contador final: $_counter'), // Muestra el resultado final.
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el cuadro de diálogo.
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador si la pantalla se cierra.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 3: Contador con Temporizador'), // Título en la barra de navegación.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos en la pantalla.
          children: <Widget>[
            Text('Tiempo restante: $_timeLeft segundos'), // Muestra el tiempo restante.
            SizedBox(height: 20), // Espaciado entre elementos.
            Text('Contador:'), // Texto descriptivo del contador.
            Text(
              '$_counter', // Muestra el valor del contador.
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20), // Espaciado entre elementos.
            ElevatedButton(
              onPressed: _startTimer, // Inicia el temporizador.
              child: Text('Iniciar Temporizador'),
            ),
            ElevatedButton(
              onPressed: _incrementCounter, // Incrementa el contador.
              child: Text('Haz Clic'),
            ),
          ],
        ),
      ),
    );
  }
}
