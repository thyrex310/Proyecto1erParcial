// Importamos los paquetes necesarios
import 'package:flutter/material.dart'; // Para la interfaz gráfica de Flutter
import 'package:sqflite/sqflite.dart'; // Para la base de datos SQLite
import 'package:path/path.dart' as path; // Para trabajar con las rutas de los archivos de la base de datos

// Creamos una clase StatefulWidget para gestionar el estado de la UI
class Practica5 extends StatefulWidget {
  @override
  _Practica5State createState() => _Practica5State(); // Crea el estado asociado
}

// Clase que contiene el estado para nuestra interfaz
class _Practica5State extends State<Practica5> {
  Database? _database; // Variable para almacenar la base de datos
  List<Map<String, dynamic>> _items = []; // Lista para almacenar los elementos de la base de datos
  final TextEditingController _nameController = TextEditingController(); // Controlador para el campo de nombre
  final TextEditingController _ageController = TextEditingController(); // Controlador para el campo de edad

  @override
  void initState() {
    super.initState();
    _initDatabase(); // Inicializamos la base de datos cuando el widget se construya
  }

  // Método para inicializar la base de datos SQLite
  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath(); // Obtiene la ruta donde se guardan las bases de datos
    final dbPath = path.join(databasePath, 'items.db'); // Crea la ruta completa para la base de datos

    // Abre la base de datos (si no existe, la crea)
    _database = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        // Si la base de datos no existe, se ejecuta esta función para crear la tabla
        return db.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)', // Define la estructura de la tabla
        );
      },
      version: 1, // Versión inicial de la base de datos
    );

    _loadItems(); // Carga los elementos de la base de datos después de abrirla
  }

  // Método para cargar los elementos de la base de datos
  Future<void> _loadItems() async {
    final List<Map<String, dynamic>> items = await _database!.query('items'); // Consulta todos los registros en la tabla 'items'
    setState(() {
      _items = items; // Actualiza el estado de la lista de elementos
    });
  }

  // Método para agregar un nuevo elemento a la base de datos
  Future<void> _addItem(String name, int age) async {
    try {
      await _database!.insert('items', {'name': name, 'age': age}); // Inserta el nuevo registro en la tabla 'items'
      _loadItems(); // Actualiza la lista después de agregar un nuevo item
      _nameController.clear(); // Limpia el campo de nombre
      _ageController.clear(); // Limpia el campo de edad
    } catch (e) {
      print('Error al agregar el registro: $e'); // Muestra un error si ocurre algún problema
    }
  }

  // Método para eliminar un item de la base de datos
  Future<void> _deleteItem(int id) async {
    await _database!.delete('items', where: 'id = ?', whereArgs: [id]); // Elimina el registro cuyo id coincida
    _loadItems(); // Actualiza la lista después de borrar el item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Práctica 5: Almacenamiento en SQLite'), // Título de la barra superior
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Aplica un padding de 16px a todo el cuerpo
        child: Column(
          children: <Widget>[
            // Campo de texto para ingresar el nombre
            TextField(
              controller: _nameController, // Controlador asociado al campo de texto
              decoration: InputDecoration(
                labelText: 'Nombre', // Etiqueta para el campo
                border: OutlineInputBorder(), // Bordes del campo
              ),
            ),
            SizedBox(height: 10), // Espacio de 10px entre los campos
            // Campo de texto para ingresar la edad
            TextField(
              controller: _ageController, // Controlador asociado al campo de texto
              decoration: InputDecoration(
                labelText: 'Edad', // Etiqueta para el campo
                border: OutlineInputBorder(), // Bordes del campo
              ),
              keyboardType: TextInputType.number, // Configura el teclado para aceptar solo números
            ),
            SizedBox(height: 20), // Espacio de 20px entre el campo de texto y el botón
            // Botón para agregar un nuevo item
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim(); // Obtiene el texto ingresado en el campo de nombre
                final age = int.tryParse(_ageController.text.trim()) ?? 0; // Convierte el texto de edad a un número

                // Verifica si el nombre y la edad son válidos
                if (name.isNotEmpty && age > 0) {
                  _addItem(name, age); // Agrega el item a la base de datos si son válidos
                } else {
                  // Muestra un mensaje de error si los datos no son válidos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, ingresa un nombre y una edad válida.'),
                    ),
                  );
                }
              },
              child: Text('Agregar Item'), // Texto que aparece en el botón
            ),
            SizedBox(height: 20), // Espacio de 20px entre el botón y la lista
            // Lista de los elementos almacenados en la base de datos
            Expanded(
              child: ListView.builder(
                itemCount: _items.length, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  final item = _items[index]; // Obtiene el item en la posición 'index'
                  return ListTile(
                    title: Text(item['name']), // Muestra el nombre del item
                    subtitle: Text('Edad: ${item['age']}'), // Muestra la edad del item
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red), // Icono de eliminación
                      onPressed: () {
                        _deleteItem(item['id']); // Elimina el item al presionar el icono
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose(); // Libera el controlador del campo de nombre
    _ageController.dispose(); // Libera el controlador del campo de edad
    super.dispose(); // Llama al método dispose de la clase base
  }
}
