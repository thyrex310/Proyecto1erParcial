package com.example.proyecto1erparcialapp

// Importación de las clases necesarias
import android.app.AlertDialog // Para mostrar cuadros de diálogo
import android.os.Bundle // Para manejar el estado de la actividad
import android.os.CountDownTimer // Para crear un temporizador con cuenta regresiva
import android.widget.Button // Para trabajar con botones en la interfaz de usuario
import android.widget.TextView // Para trabajar con elementos de texto en la interfaz
import androidx.appcompat.app.AppCompatActivity // La clase base para actividades con compatibilidad hacia atrás

// Definición de la actividad Practica3Activity
class Practica3Activity : AppCompatActivity() {

    // Declaración de variables para los elementos de la interfaz de usuario
    private lateinit var tvCounter: TextView // Variable para el TextView donde se muestra el contador
    private lateinit var tvTimer: TextView // Variable para el TextView donde se muestra el tiempo restante
    private lateinit var btnStartTimer: Button // Variable para el botón que inicia el temporizador
    private lateinit var btnIncrement: Button // Variable para el botón que incrementa el contador
    private var counter = 0 // Variable que almacena el valor del contador
    private var isTimerRunning = false // Variable que indica si el temporizador está en ejecución

    // Método que se ejecuta cuando la actividad es creada
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState) // Llamada al método de la clase base para inicializar la actividad
        setContentView(R.layout.activity_practica3) // Establece el diseño de la actividad usando el archivo XML 'activity_practica3'

        // Inicializa los elementos de la interfaz de usuario mediante su ID en el XML
        tvCounter = findViewById(R.id.tvCounter) // Encuentra el TextView para mostrar el contador
        tvTimer = findViewById(R.id.tvTimer) // Encuentra el TextView para mostrar el tiempo restante
        btnStartTimer = findViewById(R.id.btnStartTimer) // Encuentra el botón para iniciar el temporizador
        btnIncrement = findViewById(R.id.btnIncrement) // Encuentra el botón para incrementar el contador

        // Deshabilitar el botón de incrementar al inicio (cuando el temporizador no está en marcha)
        btnIncrement.isEnabled = false

        // Asocia un listener al botón de inicio del temporizador
        btnStartTimer.setOnClickListener {
            startTimer() // Llama al método para iniciar el temporizador
        }

        // Asocia un listener al botón de incremento del contador
        btnIncrement.setOnClickListener {
            counter++ // Incrementa el valor del contador
            tvCounter.text = "Contador: $counter" // Actualiza el texto del TextView para mostrar el nuevo valor del contador
        }

        // Botón para volver al menú principal
        val btnBackToMenu: Button = findViewById(R.id.btnBackToMenu) // Encuentra el botón para regresar al menú
        btnBackToMenu.setOnClickListener {
            finish() // Cierra esta actividad y regresa a MainActivity
        }
    }

    // Método que inicia el temporizador con una cuenta regresiva de 10 segundos
    private fun startTimer() {
        if (isTimerRunning) return // Evitar múltiples temporizadores (si ya está corriendo, no iniciar otro)

        isTimerRunning = true // Marca el temporizador como en ejecución
        btnStartTimer.isEnabled = false // Deshabilitar el botón de inicio para evitar que se presione mientras el temporizador está en marcha
        btnIncrement.isEnabled = true // Habilitar el botón de incrementar el contador

        // Crear un temporizador con un intervalo de 1000ms (1 segundo) durante 10000ms (10 segundos)
        object : CountDownTimer(10000, 1000) {
            // Este método se ejecuta cada vez que pasa 1 segundo (en este caso cada 1000ms)
            override fun onTick(millisUntilFinished: Long) {
                val secondsLeft = millisUntilFinished / 1000 // Calcula el tiempo restante en segundos
                tvTimer.text = "Tiempo restante: $secondsLeft segundos" // Actualiza el texto del TextView con el tiempo restante
            }

            // Este método se ejecuta cuando el temporizador ha finalizado
            override fun onFinish() {
                tvTimer.text = "Tiempo agotado!" // Muestra un mensaje indicando que el tiempo ha finalizado
                btnIncrement.isEnabled = false // Deshabilita el botón de incrementar porque el temporizador ha terminado
                showDialog() // Muestra un cuadro de diálogo con el resultado
                isTimerRunning = false // Marca el temporizador como detenido
                btnStartTimer.isEnabled = true // Habilita el botón de inicio para permitir que se inicie un nuevo temporizador
            }
        }.start() // Inicia el temporizador
    }

    // Método para mostrar un cuadro de diálogo cuando el temporizador ha terminado
    private fun showDialog() {
        AlertDialog.Builder(this) // Crea un constructor de cuadros de diálogo
            .setTitle("Temporizador Finalizado") // Establece el título del cuadro de diálogo
            .setMessage("Contador final: $counter") // Muestra el contador final en el mensaje
            .setPositiveButton("OK") { dialog, _ -> dialog.dismiss() } // Agrega un botón de "OK" que cierra el cuadro de diálogo
            .show() // Muestra el cuadro de diálogo
    }
}
