package com.example.proyecto1erparcialapp

// Importa la clase para agregar anotaciones de advertencia o eliminación de advertencias específicas
import android.annotation.SuppressLint
// Importa la clase para crear y manejar cuadros de diálogo de alerta
import android.app.AlertDialog
// Importa las clases necesarias para interactuar con una base de datos SQLite en Android
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
// Importa la clase de gestión de ciclos de vida y actividades en Android
import android.os.Bundle
// Importa la clase para trabajar con temporizadores que cuentan hacia atrás
import android.os.CountDownTimer
// Importa las clases para trabajar con botones en la interfaz de usuario
import android.widget.Button
// Importa las clases necesarias para trabajar con la interfaz de usuario, en este caso un ListView
import android.widget.ListView
// Importa las clases necesarias para mostrar texto en la interfaz de usuario
import android.widget.TextView
// Importa la clase que representa una actividad que se puede iniciar en Android
import androidx.appcompat.app.AppCompatActivity

// Clase principal que extiende de AppCompatActivity para crear una actividad en Android
class Practica6Activity : AppCompatActivity() {

    // Variables de la interfaz de usuario (UI) que corresponden a elementos de la actividad
    private lateinit var tvCounter: TextView // Se usa para mostrar el valor del contador
    private lateinit var tvTimer: TextView // Se usa para mostrar el tiempo restante en el temporizador
    private lateinit var btnStartTimer: Button // Botón para iniciar el temporizador
    private lateinit var btnIncrement: Button // Botón para incrementar el contador
    private lateinit var lvScores: ListView // ListView para mostrar las puntuaciones guardadas
    private var counter = 0 // Variable para llevar el conteo de las veces que se incrementa el contador
    private var isTimerRunning = false // Indicador para verificar si el temporizador está en ejecución
    private lateinit var dbHelper: SQLiteOpenHelper // Objeto para manejar la base de datos SQLite
    private lateinit var database: SQLiteDatabase // Objeto para interactuar con la base de datos SQLite

    // Función onCreate que es llamada cuando se crea la actividad
    @SuppressLint("MissingInflatedId") // Suprime advertencias por posibles problemas con la inflación de vistas
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_practica6) // Establece el diseño XML para esta actividad

        // Inicialización de los elementos de la UI
        tvCounter = findViewById(R.id.tvCounter) // Asigna el TextView para mostrar el contador
        tvTimer = findViewById(R.id.tvTimer) // Asigna el TextView para mostrar el temporizador
        btnStartTimer = findViewById(R.id.btnStartTimer) // Asigna el botón para iniciar el temporizador
        btnIncrement = findViewById(R.id.btnIncrement) // Asigna el botón para incrementar el contador
        lvScores = findViewById(R.id.lvScores) // Asigna el ListView para mostrar las puntuaciones

        // Inicializa el botón de incremento para que esté deshabilitado al principio
        btnIncrement.isEnabled = false // Solo habilitará cuando el temporizador comience

        // Configura un SQLiteOpenHelper para gestionar la base de datos SQLite
        dbHelper = object : SQLiteOpenHelper(this, "scores.db", null, 1) {
            // Función que se ejecuta cuando la base de datos es creada por primera vez
            override fun onCreate(db: SQLiteDatabase) {
                // Se ejecuta una instrucción SQL para crear una tabla 'scores' con dos columnas: id y score
                db.execSQL("CREATE TABLE scores(id INTEGER PRIMARY KEY, score INTEGER)")
            }

            // Función que se ejecuta si la versión de la base de datos cambia
            override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
                // Elimina la tabla de puntuaciones si existe, para luego crearla nuevamente
                db.execSQL("DROP TABLE IF EXISTS scores")
                onCreate(db) // Re-crea la base de datos con la nueva versión
            }
        }

        // Establece un objeto de base de datos en modo escritura para permitir la modificación de datos
        database = dbHelper.writableDatabase

        // Configura el botón de inicio para que inicie el temporizador al hacer clic
        btnStartTimer.setOnClickListener {
            startTimer() // Llama a la función para comenzar el temporizador
        }

        // Configura el botón de incremento para que aumente el contador al hacer clic
        btnIncrement.setOnClickListener {
            counter++ // Incrementa el contador
            tvCounter.text = "Contador: $counter" // Actualiza el texto del TextView con el nuevo valor del contador
        }

        // Configura un botón para regresar al menú principal
        val btnBackToMenu: Button = findViewById(R.id.btnBackToMenu) // Asigna el botón para regresar
        btnBackToMenu.setOnClickListener {
            finish() // Finaliza la actividad actual y regresa a la MainActivity
        }

        // Carga las puntuaciones guardadas desde la base de datos
        loadScores() // Llama a la función para cargar las puntuaciones al iniciar la actividad
    }

    // Función que inicia el temporizador
    private fun startTimer() {
        if (isTimerRunning) return // Si el temporizador ya está en ejecución, no hacer nada

        isTimerRunning = true // Marca que el temporizador está en ejecución
        btnStartTimer.isEnabled = false // Deshabilita el botón de inicio del temporizador
        btnIncrement.isEnabled = true // Habilita el botón de incremento para que el usuario pueda incrementar el contador

        // Crea un temporizador que contará hacia atrás desde 10 segundos
        object : CountDownTimer(10000, 1000) {
            // Esta función se llama cada segundo mientras el temporizador está corriendo
            override fun onTick(millisUntilFinished: Long) {
                val secondsLeft = millisUntilFinished / 1000 // Calcula los segundos restantes
                tvTimer.text = "Tiempo restante: $secondsLeft segundos" // Actualiza el texto con los segundos restantes
            }

            // Esta función se llama cuando el temporizador ha finalizado
            override fun onFinish() {
                tvTimer.text = "Tiempo agotado!" // Muestra el mensaje "Tiempo agotado"
                btnIncrement.isEnabled = false // Deshabilita el botón de incrementar el contador
                saveScore() // Guarda la puntuación actual en la base de datos
                showDialog() // Muestra un cuadro de diálogo con la puntuación final
                isTimerRunning = false // Marca que el temporizador ha terminado
                btnStartTimer.isEnabled = true // Habilita el botón de inicio para comenzar otro temporizador
            }
        }.start() // Inicia el temporizador
    }

    // Función que guarda la puntuación en la base de datos
    private fun saveScore() {
        // Ejecuta una sentencia SQL para insertar la puntuación actual en la tabla 'scores'
        database.execSQL("INSERT INTO scores(score) VALUES($counter)")
        loadScores() // Vuelve a cargar las puntuaciones después de guardar la nueva
    }

    // Función que carga las puntuaciones desde la base de datos
    private fun loadScores() {
        // Ejecuta una consulta SQL para obtener las 5 puntuaciones más altas
        val cursor = database.rawQuery("SELECT score FROM scores ORDER BY score DESC LIMIT 5", null)
        val scores = mutableListOf<String>() // Lista mutable para almacenar las puntuaciones

        // Recorre el cursor para obtener las puntuaciones desde la base de datos
        while (cursor.moveToNext()) {
            val score = cursor.getInt(0) // Obtiene el valor de la columna 'score'
            scores.add("Score: $score") // Agrega la puntuación a la lista
        }
        cursor.close() // Cierra el cursor para liberar recursos

        // Crea un adaptador para mostrar las puntuaciones en el ListView
        val adapter = android.widget.ArrayAdapter(this, android.R.layout.simple_list_item_1, scores)
        lvScores.adapter = adapter // Asigna el adaptador al ListView para mostrar las puntuaciones
    }

    // Función que muestra un cuadro de diálogo con el resultado final del temporizador
    private fun showDialog() {
        // Crea un cuadro de diálogo con un título, un mensaje y un botón OK
        AlertDialog.Builder(this)
            .setTitle("Temporizador Finalizado") // Título del cuadro de diálogo
            .setMessage("Contador final: $counter") // Muestra el valor final del contador en el mensaje
            .setPositiveButton("OK") { dialog, _ -> dialog.dismiss() } // Botón OK para cerrar el cuadro de diálogo
            .show() // Muestra el cuadro de diálogo en pantalla
    }

    // Función que se llama cuando la actividad es destruida
    override fun onDestroy() {
        super.onDestroy() // Llama al método onDestroy de la clase base para limpiar
        database.close() // Cierra la base de datos para liberar recursos
    }
}
