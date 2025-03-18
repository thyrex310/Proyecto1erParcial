package com.example.proyecto1erparcialapp

// Importación de clases necesarias
import android.content.Intent // Para manejar las intenciones de cambio de actividad
import android.os.Bundle // Para manejar el estado de la actividad
import android.widget.Button // Para manejar los botones en la interfaz de usuario
import androidx.appcompat.app.AppCompatActivity // Clase base para actividades con soporte para la ActionBar

// Definición de la clase Practica1Activity que extiende AppCompatActivity
class Practica1Activity : AppCompatActivity() {

    // Método onCreate, llamado cuando la actividad es creada
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState) // Llamada al método de la clase base para inicializar la actividad
        setContentView(R.layout.activity_practica1) // Establece el diseño de la actividad usando el archivo XML 'activity_practica1'

        // Encuentra el botón con el ID 'btnBackToMenu' en el diseño de la actividad
        val btnBackToMenu: Button = findViewById(R.id.btnBackToMenu)

        // Asigna un listener para manejar el evento de clic en el botón
        btnBackToMenu.setOnClickListener {
            // Llama al método 'finish()' para cerrar la actividad actual (Practica1Activity)
            // Esto regresa a la actividad anterior en la pila, que es la MainActivity
            finish()
        }
    }
}
