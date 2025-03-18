Proyecto1erParcialApp
Este proyecto es una aplicación de Android desarrollada en Kotlin y flutter que implementa varias prácticas relacionadas con el manejo de interfaces de usuario, temporizadores, almacenamiento en archivos de texto y bases de datos SQLite.

Descripción
La aplicación consta de un menú principal desde donde se puede acceder a diferentes prácticas:

Práctica 1: Muestra un mensaje "Hola Mundo" y tiene un botón para volver al menú principal.

Práctica 2: Implementa un contador de clics con un botón que incrementa el contador.

Práctica 3: Contador con temporizador de 10 segundos. El botón de incrementar se deshabilita después de que el temporizador termina.

Práctica 4: Similar a la Práctica 3, pero guarda el score en un archivo de texto y muestra un scoreboard con los mejores 5 scores.

Práctica 5: Almacena nombres y edades en una base de datos SQLite y los muestra en una lista.

Práctica 6: Similar a la Práctica 4, pero guarda los scores en una base de datos SQLite y muestra un scoreboard.

Requisitos
Android Studio (versión recomendada: Arctic Fox o superior).

Dispositivo Android o emulador con API nivel 21 (Android 5.0 Lollipop) o superior.

Configuración
Clona este repositorio o descarga el código fuente.

Abre el proyecto en Android Studio.

Sincroniza el proyecto con Gradle (Android Studio lo hará automáticamente en la mayoría de los casos).

Conecta un dispositivo Android o inicia un emulador.

Ejecuta la aplicación haciendo clic en el botón Run (▶️) en Android Studio.

Estructura del Proyecto
MainActivity.kt: Actividad principal que muestra el menú con botones para acceder a las prácticas.

Practica1Activity.kt: Muestra un mensaje "Hola Mundo" y tiene un botón para volver al menú.

Practica2Activity.kt: Implementa un contador de clics.

Practica3Activity.kt: Contador con temporizador de 10 segundos.

Practica4Activity.kt: Guarda el score en un archivo de texto y muestra un scoreboard.

Practica5Activity.kt: Almacena nombres y edades en SQLite y los muestra en una lista.

Practica6Activity.kt: Guarda los scores en SQLite y muestra un scoreboard.

Uso
Menú Principal:

Al abrir la aplicación, se muestra un menú con botones para acceder a cada práctica.

Haz clic en el botón correspondiente para abrir la práctica deseada.

Práctica 1:

Muestra un mensaje "Hola Mundo".

Usa el botón "Volver al Menú" para regresar al menú principal.

Práctica 2:

Haz clic en el botón "Haz Clic" para incrementar el contador.

Práctica 3:

Haz clic en "Iniciar Temporizador" para comenzar el temporizador de 10 segundos.

Usa el botón "Haz Clic" para incrementar el contador mientras el temporizador esté activo.

Práctica 4:

Similar a la Práctica 3, pero guarda el score en un archivo de texto.

Muestra un scoreboard con los mejores 5 scores.

Práctica 5:

Ingresa un nombre y una edad en los campos de texto.

Haz clic en "Agregar" para guardar los datos en la base de datos SQLite.

Los datos se muestran en una lista debajo del formulario.

Práctica 6:

Similar a la Práctica 4, pero guarda los scores en una base de datos SQLite.

Muestra un scoreboard con los mejores 5 scores.
