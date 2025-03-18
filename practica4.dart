import 'dart:io'; // Importa la biblioteca para manejar archivos (lectura, escritura, etc.)
import 'package:flutter/material.dart'; // Importa Flutter para la interfaz gráfica
import 'package:path_provider/path_provider.dart'; // Importa la biblioteca para obtener rutas de almacenamiento
import 'dart:async'; // Importa la biblioteca para manejar temporizadores (Timer)

// Clase principal del widget
class Practica4 extends StatefulWidget {
  @override
  _Practica4State createState() => _Practica4State(); // Crea el estado asociado al widget
}

// Estado del widget que maneja la lógica del temporizador y el almacenamiento de datos
class _Practica4State extends State<Practica4> {
  int _counter = 0; // Contador de clics
  bool _isRunning = false; // Bandera que indica si el temporizador está en ejecución
  int _timeLeft = 10; // Tiempo restante del temporizador en segundos
  Timer? _timer; // Objeto Timer que controla el temporizador
  List<String> _history = []; // Lista que guarda el historial de los contadores
  List<int> _scores = []; // Lista que guarda los mejores puntajes

  // Método para iniciar el temporizador
  void _startTimer() {
    if (_isRunning) return; // Si el temporizador ya está corriendo, no hace nada

    setState(() {
      _isRunning = true; // Marca que el temporizador está corriendo
      _timeLeft = 10; // Resetea el tiempo a 10 segundos
      _counter = 0; // Resetea el contador
    });

    // Crea un temporizador que se ejecuta cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--; // Decrementa el tiempo restante cada segundo
        } else {
          _isRunning = false; // Detiene el temporizador cuando el tiempo se acaba
          timer.cancel(); // Cancela el temporizador
          _saveHistory(); // Guarda el historial cuando el tiempo se acaba
          _showDialog(); // Muestra un cuadro de diálogo con el resultado
        }
      });
    });
  }

  // Método para incrementar el contador cuando el usuario hace clic en el botón
  void _incrementCounter() {
    if (_isRunning) {
      setState(() {
        _counter++; // Incrementa el contador en uno
      });
    }
  }

  // Método para guardar el historial en un archivo de texto
  void _saveHistory() async {
    final directory = await getApplicationDocumentsDirectory(); // Obtiene el directorio de documentos
    final file = File('${directory.path}/history.txt'); // Crea o abre un archivo de texto llamado 'history.txt'
    _history.add('Contador: $_counter'); // Agrega la entrada del contador actual al historial
    await file.writeAsString(_history.join('\n')); // Escribe el historial en el archivo como texto separado por saltos de línea
    _loadScores(); // Después de guardar, carga los puntajes más altos del historial
  }

  // Método para cargar los puntajes almacenados en el archivo
  void _loadScores() async {
    final directory = await getApplicationDocumentsDirectory(); // Obtiene el directorio de documentos
    final file = File('${directory.path}/history.txt'); // Accede al archivo 'history.txt'
    if (await file.exists()) {
      final content = await file.readAsString(); // Lee el contenido del archivo
      final lines = content.split('\n'); // Separa las líneas del archivo
      final scores = lines
          .where((line) => line.startsWith('Contador: ')) // Filtra las líneas que comienzan con 'Contador: '
          .map((line) => int.parse(line.replaceAll('Contador: ', ''))) // Extrae el número después de 'Contador: ' y lo convierte en entero
          .toList(); // Convierte las líneas filtradas en una lista de enteros
      scores.sort((a, b) => b.compareTo(a)); // Ordena los puntajes de mayor a menor
      setState(() {
        _scores = scores.take(5).toList(); // Guarda los 5 mejores puntajes
      });
    }
  }

  // Método para mostrar un cuadro de diálogo al finalizar el temporizador
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Temporizador Finalizado'), // Título del cuadro de diálogo
          content: Text('Contador final: $_counter'), // Muestra el contador final
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el cuadro de diálogo al presionar 'OK'
              },
              child: Text('OK'), // Texto del botón 'OK'
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadScores(); // Al iniciar la pantalla, carga los puntajes más altos almacenados
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador si está activo cuando el widget es destruido
    super.dispose(); // Llama al método dispose de la clase base
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 4: Historial en Archivo de Texto'), // Título de la barra de la app
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos en la pantalla
          children: <Widget>[
            // Muestra el tiempo restante en el temporizador
            Text('Tiempo restante: $_timeLeft segundos'),
            SizedBox(height: 20), // Espacio entre los elementos
            // Muestra el texto 'Contador'
            Text('Contador:'),
            // Muestra el contador actual en un formato grande
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium, // Estilo del texto
            ),
            SizedBox(height: 20), // Espacio entre los elementos
            // Botón para iniciar el temporizador
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Iniciar Temporizador'),
            ),
            // Botón para incrementar el contador al hacer clic
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Haz Clic'),
            ),
            SizedBox(height: 20), // Espacio entre los elementos
            // Título que indica la sección de los mejores puntajes
            Text(
              'Mejores 5 Scores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de texto
            ),
            // Lista que muestra los 5 mejores puntajes
            Expanded(
              child: ListView.builder(
                itemCount: _scores.length, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index + 1}. ${_scores[index]}'), // Muestra el índice y puntaje
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
