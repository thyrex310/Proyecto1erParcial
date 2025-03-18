package com.example.proyecto1erparcialapp

// Importación de las clases necesarias para trabajar con bases de datos, interfaces de usuario y otras funciones
import android.annotation.SuppressLint // Para suprimir advertencias de InflatedId
import android.database.sqlite.SQLiteDatabase // Para trabajar con la base de datos SQLite
import android.database.sqlite.SQLiteOpenHelper // Para manejar la creación y actualización de la base de datos SQLite
import android.os.Bundle // Para manejar el estado de la actividad
import android.widget.Button // Para trabajar con botones en la interfaz de usuario
import android.widget.EditText // Para trabajar con campos de texto en la interfaz de usuario
import android.widget.ListView // Para mostrar una lista de elementos en la interfaz de usuario
import androidx.appcompat.app.AppCompatActivity // La clase base para actividades con compatibilidad hacia atrás

// Definición de la actividad Practica5Activity
class Practica5Activity : AppCompatActivity() {

    // Declaración de las variables para los elementos de la interfaz de usuario
    private lateinit var etName: EditText // Campo de texto para ingresar el nombre
    private lateinit var etAge: EditText // Campo de texto para ingresar la edad
    private lateinit var btnAdd: Button // Botón para agregar un nuevo elemento a la base de datos
    private lateinit var lvItems: ListView // Lista que mostrará los elementos guardados en la base de datos
    private lateinit var dbHelper: SQLiteOpenHelper // Objeto para manejar la creación y actualización de la base de datos
    private lateinit var database: SQLiteDatabase // Objeto para acceder y modificar la base de datos SQLite

    // Método que se ejecuta cuando se crea la actividad
    @SuppressLint("MissingInflatedId") // Suprime la advertencia por los elementos inflados
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState) // Llama al método de la clase base para inicializar la actividad
        setContentView(R.layout.activity_practica5) // Establece el diseño de la actividad usando el archivo XML 'activity_practica5'

        // Inicializa los elementos de la interfaz de usuario a través de sus identificadores en el XML
        etName = findViewById(R.id.etName) // Campo de texto para el nombre
        etAge = findViewById(R.id.etAge) // Campo de texto para la edad
        btnAdd = findViewById(R.id.btnAdd) // Botón para agregar un nuevo elemento
        lvItems = findViewById(R.id.lvItems) // Lista para mostrar los elementos guardados

        // Crea un SQLiteOpenHelper para administrar la base de datos 'items.db'
        dbHelper = object : SQLiteOpenHelper(this, "items.db", null, 1) {
            // Método para crear la tabla en la base de datos cuando no existe
            override fun onCreate(db: SQLiteDatabase) {
                // Crea la tabla 'items' con las columnas id, name y age
                db.execSQL("CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)")
            }

            // Método para actualizar la base de datos cuando cambia la versión
            override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
                // Si la base de datos ya existe, elimina la tabla 'items' y vuelve a crearla
                db.execSQL("DROP TABLE IF EXISTS items")
                onCreate(db) // Llama a onCreate para crear la tabla nuevamente
            }
        }

        // Obtiene una instancia de la base de datos en modo de escritura
        database = dbHelper.writableDatabase

        // Asocia un listener al botón de agregar
        btnAdd.setOnClickListener {
            // Obtiene el nombre y la edad del usuario desde los campos de texto
            val name = etName.text.toString()
            val age = etAge.text.toString().toIntOrNull() ?: 0 // Convierte la edad a entero, o usa 0 si no es válida
            // Verifica si el nombre no está vacío y la edad es mayor que 0
            if (name.isNotEmpty() && age > 0) {
                // Inserta el nuevo elemento en la tabla 'items' de la base de datos
                database.execSQL("INSERT INTO items(name, age) VALUES('$name', $age)")
                // Limpia los campos de texto
                etName.text.clear()
                etAge.text.clear()
                // Carga los elementos de la base de datos nuevamente en la lista
                loadItems()
            }
        }

        // Botón para regresar al menú principal
        val btnBackToMenu: Button = findViewById(R.id.btnBackToMenu) // Encuentra el botón de regreso al menú
        btnBackToMenu.setOnClickListener {
            finish() // Cierra esta actividad y regresa a MainActivity
        }

        // Carga los elementos de la base de datos al iniciar la actividad
        loadItems()
    }

    // Método que carga los elementos de la base de datos y los muestra en la lista
    private fun loadItems() {
        // Realiza una consulta a la base de datos para obtener todos los elementos de la tabla 'items'
        val cursor = database.rawQuery("SELECT * FROM items", null)
        // Crea una lista mutable para almacenar los elementos
        val items = mutableListOf<String>()
        // Recorre los resultados de la consulta (el cursor)
        while (cursor.moveToNext()) {
            // Obtiene el nombre y la edad de cada fila
            val name = cursor.getString(1)
            val age = cursor.getInt(2)
            // Agrega el nombre y la edad a la lista en formato de texto
            items.add("$name - $age años")
        }
        cursor.close() // Cierra el cursor después de usarlo

        // Crea un adaptador para la ListView con los elementos cargados
        val adapter = android.widget.ArrayAdapter(this, android.R.layout.simple_list_item_1, items)
        lvItems.adapter = adapter // Establece el adaptador en la ListView
    }

    // Método que se ejecuta cuando la actividad es destruida (se cierra)
    override fun onDestroy() {
        super.onDestroy() // Llama al método de la clase base para manejar la destrucción
        database.close() // Cierra la base de datos cuando ya no se necesita
    }
}
