package com.example.proyecto1erparcialapp

// Importación de clases necesarias
import android.content.Intent // Para manejar las intenciones de cambio de actividad
import android.os.Bundle // Para manejar el estado de la actividad
import android.widget.Button // Para manejar los botones de la interfaz de usuario
import androidx.appcompat.app.AppCompatActivity // Clase base para actividades con soporte para la ActionBar

// Definición de la clase MainActivity que extiende AppCompatActivity
class MainActivity : AppCompatActivity() {

    // Método onCreate, llamado cuando la actividad es creada
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState) // Llamada al método de la clase base para inicializar la actividad
        setContentView(R.layout.activity_main) // Establece el diseño de la actividad usando un archivo XML

        // Asignación de un listener al botón con ID btnPractica1 para navegar a la actividad Practica1Activity
        findViewById<Button>(R.id.btnPractica1).setOnClickListener {
            // Inicia la actividad Practica1Activity al hacer clic en el botón
            startActivity(Intent(this, Practica1Activity::class.java))
        }

        // Asignación de un listener al botón con ID btnPractica2 para navegar a la actividad Practica2Activity
        findViewById<Button>(R.id.btnPractica2).setOnClickListener {
            // Inicia la actividad Practica2Activity al hacer clic en el botón
            startActivity(Intent(this, Practica2Activity::class.java))
        }

        // Asignación de un listener al botón con ID btnPractica3 para navegar a la actividad Practica3Activity
        findViewById<Button>(R.id.btnPractica3).setOnClickListener {
            // Inicia la actividad Practica3Activity al hacer clic en el botón
            startActivity(Intent(this, Practica3Activity::class.java))
        }

        // Asignación de un listener al botón con ID btnPractica4 para navegar a la actividad Practica4Activity
        findViewById<Button>(R.id.btnPractica4).setOnClickListener {
            // Inicia la actividad Practica4Activity al hacer clic en el botón
            startActivity(Intent(this, Practica4Activity::class.java))
        }

        // Asignación de un listener al botón con ID btnPractica5 para navegar a la actividad Practica5Activity
        findViewById<Button>(R.id.btnPractica5).setOnClickListener {
            // Inicia la actividad Practica5Activity al hacer clic en el botón
            startActivity(Intent(this, Practica5Activity::class.java))
        }

        // Asignación de un listener al botón con ID btnPractica6 para navegar a la actividad Practica6Activity
        findViewById<Button>(R.id.btnPractica6).setOnClickListener {
            // Inicia la actividad Practica6Activity al hacer clic en el botón
            startActivity(Intent(this, Practica6Activity::class.java))
        }
    }
}
