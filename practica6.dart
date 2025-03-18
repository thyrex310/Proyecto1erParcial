// Importamos los paquetes necesarios
import 'package:flutter/material.dart'; // Para la interfaz gráfica de Flutter
import 'package:sqflite/sqflite.dart'; // Para trabajar con la base de datos SQLite
import 'package:path/path.dart' as path; // Para trabajar con las rutas de archivos
import 'dart:async'; // Para manejar temporizadores (Timer)

class Practica6 extends StatefulWidget {
  @override
  _Practica6State createState() => _Practica6State(); // Crea el estado asociado al widget
}

class _Practica6State extends State<Practica6> {
  int _counter = 0; // Variable para llevar el conteo de los clics
  bool _isRunning = false; // Variable para saber si el temporizador está corriendo
  int _timeLeft = 10; // Tiempo restante para el temporizador
  Timer? _timer; // Variable para manejar el temporizador
  Database? _database; // Base de datos para almacenar el historial de los contadores
  List<Map<String, dynamic>> _history = []; // Lista para almacenar el historial de la base de datos
  List<int> _scores = []; // Lista para almacenar los mejores puntajes

  @override
  void initState() {
    super.initState();
    _initDatabase(); // Inicializa la base de datos cuando el widget se construya
  }

  // Método para inicializar la base de datos SQLite
  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath(); // Obtiene la ruta donde se almacenan las bases de datos
    final dbPath = path.join(databasePath, 'counter_history.db'); // Ruta completa para la base de datos

    // Abre la base de datos (si no existe, la crea)
    _database = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        // Si la base de datos no existe, ejecuta esta función para crear la tabla
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY, count INTEGER)', // Crea una tabla 'history' con id y count
        );
      },
      version: 1, // Versión inicial de la base de datos
    );

    _loadHistory(); // Carga el historial de contadores desde la base de datos
  }

  // Método para cargar el historial de la base de datos
  Future<void> _loadHistory() async {
    final List<Map<String, dynamic>> history = await _database!.query('history'); // Consulta todos los registros en la tabla 'history'
    setState(() {
      _history = history; // Actualiza el historial con los datos cargados
      _scores = history.map((item) => item['count'] as int).toList(); // Convierte los datos a una lista de puntajes
      _scores.sort((a, b) => b.compareTo(a)); // Ordena los puntajes de mayor a menor
      _scores = _scores.take(5).toList(); // Toma los primeros 5 puntajes (mejores)
    });
  }

  // Método para guardar el contador en la base de datos
  Future<void> _saveCount(int count) async {
    await _database!.insert('history', {'count': count}); // Inserta el contador en la tabla 'history'
    _loadHistory(); // Vuelve a cargar el historial para actualizar la lista de puntajes
  }

  // Método para iniciar el temporizador
  void _startTimer() {
    if (_isRunning) return; // Si el temporizador ya está corriendo, no hacer nada

    setState(() {
      _isRunning = true; // Marca el temporizador como en ejecución
      _timeLeft = 10; // Resetea el tiempo restante a 10 segundos
      _counter = 0; // Resetea el contador
    });

    // Inicia el temporizador que se ejecuta cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--; // Decrementa el tiempo restante
        } else {
          _isRunning = false; // Detiene el temporizador cuando el tiempo se agota
          timer.cancel(); // Cancela el temporizador
          _saveCount(_counter); // Guarda el contador en la base de datos
          _showDialog(); // Muestra el cuadro de diálogo con el resultado
        }
      });
    });
  }

  // Método para incrementar el contador cuando el usuario hace clic en el botón
  void _incrementCounter() {
    if (_isRunning) {
      setState(() {
        _counter++; // Aumenta el contador en 1
      });
    }
  }

  // Método para mostrar el cuadro de diálogo con el resultado cuando el temporizador termina
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
                Navigator.of(dialogContext).pop(); // Cierra el cuadro de diálogo
              },
              child: Text('OK'), // Botón para cerrar el cuadro de diálogo
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador si está activo cuando el widget se destruye
    super.dispose(); // Llama al método dispose de la clase base
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 6: Historial en SQLite'), // Título de la barra superior
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos dentro del Column
          children: <Widget>[
            // Muestra el tiempo restante del temporizador
            Text('Tiempo restante: $_timeLeft segundos'),
            SizedBox(height: 20), // Espacio de 20px
            // Muestra el texto "Contador"
            Text('Contador:'),
            // Muestra el valor actual del contador en un estilo grande
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20), // Espacio de 20px
            // Botón para iniciar el temporizador
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Iniciar Temporizador'),
            ),
            // Botón para incrementar el contador
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Haz Clic'),
            ),
            SizedBox(height: 20), // Espacio de 20px
            // Título de la sección de los mejores puntajes
            Text(
              'Mejores 5 Scores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Lista que muestra los mejores 5 puntajes
            Expanded(
              child: ListView.builder(
                itemCount: _scores.length, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index + 1}. ${_scores[index]}'), // Muestra el puntaje con su posición
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
