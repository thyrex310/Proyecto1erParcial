package com.example.proyecto1erparcialapp

// Importación de las clases necesarias
import android.os.Bundle // Para trabajar con el estado de la actividad
import android.widget.Button // Para trabajar con botones en la interfaz de usuario
import android.widget.TextView // Para trabajar con los elementos de texto en la interfaz
import androidx.appcompat.app.AppCompatActivity // La clase base para actividades con compatibilidad hacia atrás

// Definición de la actividad Practica2Activity
class Practica2Activity : AppCompatActivity() {

    // Declaración de variables para los elementos de la interfaz de usuario
    private lateinit var tvCounter: TextView // Variable para el TextView donde se muestra el contador
    private lateinit var btnIncrement: Button // Variable para el botón de incremento
    private var counter = 0 // Variable que almacena el valor del contador

    // Método que se ejecuta cuando la actividad es creada
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState) // Llamada al método de la clase base para inicializar la actividad
        setContentView(R.layout.activity_practica2) // Establece el diseño de la actividad usando el archivo XML 'activity_practica2'

        // Inicializa los elementos de la interfaz de usuario mediante su ID en el XML
        tvCounter = findViewById(R.id.tvCounter) // Encuentra el TextView con el ID 'tvCounter'
        btnIncrement = findViewById(R.id.btnIncrement) // Encuentra el Button con el ID 'btnIncrement'

        // Asocia un listener al botón de incremento
        btnIncrement.setOnClickListener {
            counter++ // Incrementa el valor del contador en 1
            tvCounter.text = "Contador: $counter" // Actualiza el texto del TextView para mostrar el valor del contador
        }

        // Botón para volver al menú principal
        val btnBackToMenu: Button = findViewById(R.id.btnBackToMenu) // Encuentra el botón para regresar al menú
        btnBackToMenu.setOnClickListener {
            finish() // Cierra esta actividad y regresa a MainActivity
        }
    }
}
