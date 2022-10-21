# Automatización de servicios - Dummy API

A continuación, se explicará la composición y consideraciones necesarias para interactuar por medio de automatizaciones con Dimmy API.

## Comenzando

En este proyecto se pondrá en práctica conocimientos para automatizaciones de pruebas aplicadas a servicios y, además, la ejecución de las pruebas por medio de Jenkins, el cual estará en un contenedor de Docker.

Este proyecto ilustra cómo trabajar con Karate Framework y cómo ejecutar las automatizaciones por medio de pipelines y Jenkins.

### Prerrequisitos

Todo el proceso de ejecución de pruebas se hará localmente. Ten presente los siguientes prerrequisitos para tener una buena experiencia de replicación. Además, si no se indica una versión para alguna herramienta pues deberás asegurar la versión más reciente.
```
Java 8+
InteliJ IDEA
Gradle
Git
Doker
```

### Adecuación local del proyecto de automatización

Antes que nada, debes clonar el repositorio en tu equipo. Y si, eso es todo ya que se supone que dispones de los prerrequisitos.


```
https://github.com/ivanarroyave/dummyapiWitKarateFramework.git
```


Una vez hecho, verás la carpeta "dummyapiWitKarateFramework" la cual se generó por la clonación del repositorio; a su vez contiene, el proyecto de automatización está dentro de otra carpeta también llamada "dummyapiWitKarateFramework".

## Ejecutando las pruebas

Primero deberás abrir el proyecto de automatización:
* Haga clic en Archivo > Abrir.
* Navegue hasta el archivo build.gradle del proyecto.
* Haga clic en Aceptar.

### Analice las pruebas

Las pruebas en este proyecto se basan en las funcionalidades descritas en https://dummyapi.io/docs/user y https://dummyapi.io/docs/errors.
Se han automatizado un conjunto de escenarios de pruebas entre rutas ideales y alternas. Las descripciones de los Features y sus respectivos Scenarios las puede encontrar en la ruta: "src/test/resources/features/user".

Existen muchas versiones de runner. Al nivel de las funcionalidades puntuales y a un nivel 
principal como lo podrá observar en el paquete "src/test/java/io/dummyapi/runners".
```
* ParallelRunnerTest: para ejecuciones paralelas de todos los test en el proyecto. 
                      Genera evidencias de pruebas en el formato de Cucumber.
                      
* SampleRunnerTest: para ejecuciones de pruebas en forma consecutiva en el mismo hilo de ejecución.
                    Genera evidencias de prueba en el formato de Karate Framework.
                    
* NOTA: existen otros paquetes runner a nivel de cada funcionalidad de servicio; 
        también poseen un subpaquete "runners" que sigue la misma lógica antes descrita.
```

### Ejecute localmente las pruebas y genere un reporte de pruebas

Para ejecutar las pruebas deberá hacerlo desde una consola o terminal (en este caso para que los comandos queden como referencia y se puedan usar en un pipeline). Navegue hasta donde se encuentre el archivo build.gradle. Ahora, desde la consola:

Limpie el proyecto de archivos temporales.
```
gradle clean
```

Si desea, para limpiar el proyecto de archivos temporales y compilar.
```
gradle clean build -x test
```

Ejecute una o varias pruebas. Para la ejecución de pruebas el comando es diverso. Veamos un ejemplo para ejecutar un runner específico; será el runner de ejecución paralela. La idea de este formato es ejecutar todos los escenarios (cuando desee, inspeccione el runner "ParallelRunnerTest" para ver su configuración).
```
gradle test --tests *runners.ParallelRunnerTest*

NOTA: los símbolos de asterisco (*) son comodines para que Gradle resuleva rutas relativas.

NOTA: puedes crear diferentes runners que internamente posean una ruta de test a ejecutar. Es decir,
      rutas que sean de regresión, smoke test, sanidad, E2E, etc. Finalmente la idea es que crees pipelines con 
      diferentes rutas de ejecución de pruebas.
```

Con Karate Framework el reporte se genera automáticamente después de ejecutar las pruebas. 

En este proyecto, en caso de ejecutar las pruebas con el runner "ParallelRunnerTest" el reporte de Cucumber se genera normalmente en la ruta: "./dummyapiWitKarate/build/cucumber-html-reports/". Para verlo, debe abrir el archivo "overview-features.html".

En este proyecto, en caso de ejecutar las pruebas con el runner "SampleRunnerTest" el reporte puro de Karate se genera normalmente en la ruta: "./dummyapiWitKarate/build/karate-reports/". Para verlo, debe abrir el archivo "karate-summary.html".



### Ejecute localmente las pruebas y genere un reporte de pruebas desde un contenedor de Docker con una imagen de Jenkins
De antemano ten presente que nos va a interesar guardar las configuraciones de Jenkins en un volumen de Docker externo al contenedor. Una vez que se configure Jenkins no queremos repetir el proceso una y otra vez si por alguna razón perdemos el contenedor. Mejor tenerlo a la mano para reusar las configuraciones de Jenkins (plugin instalados, pipelines configurados, usuarios, etc.) en un nuevo contenedor.

#### Ejecución dede una imagen de Docker
* Crea una carpeta por fuera del proyecto llamado "jenkins_home". Yo lo haré en la carpeta Downloads. En dicha carpeta quedarán todas las configuraciones que se harán en Jenkins.
* Crea un Dockerfile en la raíz del proyecto de automatización (donde está el archivo README.md y otros). Usa el block de notas o una herramienta similar para editar. Al final nos interesa tener un archivo que sin extensión tendrá el nombre de "Dockerfile".
* Dentro del archivo Dockerfile tendremos la siguiente configuración:
```
FROM jenkins/jenkins:latest
MAINTAINER dario696 ddario696@gmail.com
USER root
RUN apt-get update
RUN apt install gradle -y
EXPOSE 8080
```

* Para crear la imagen en Docker debes abrir la línea de comandos y ubicarte donde está el Dockerfile. Ejecuta el siguiente comando. No olvide tener en cuenta el punto (.).
```
docker build -t jenkins_karate .
```

* Cuando el proceso de la consola termine podrás comprobar que se ha creado una imagen con el nombre "jenkins_karate". Usa el siguiente comando para listar las imágenes de Docker.
```
docker images
```

* Ahora se procede con la creación del contenedor.
```
docker run -p 8080:8080 --name dummyapi_karate -d -v C:/Users/pc/Downloads/jenkins_home:/var/jenkins_home jenkins_karate
```

* Ahora puedes buscar tu contenedor. Para listar los contenedores creados usa el siguiente comando:
```
docker container ls
```

* Para ejecutar comandos dentro del contenedor debes usar el siguiente comando (usa "exit" para salir del modo interactivo):
```
docker exec -it dummyapi_karate bash
```

* Una vez adentro del contenedor podrías ejecutar un comando. Por ejemplo verifica la versión de Java o de Gradle.
```
java -version
gradle -version
```

* A estas alturas si abres el navegador web y en la barra de dirección pones "http://localhost:8080/" verás que Jenkin se mostrará y pedirá una contraseña. Usa el modo interactivo para usar el siguiente comando (el código lo debes poner donde dice "Administrator password", luego das en continuar):
```
cat /var/jenkins_home/secrets/initialAdminPassword
```

* Jenkins ofrece dos opciones de instalación de plugin. Escoge los plugin sugeridos. Espera a que finalice la instalación de plugin. Continue con la creación de un usuario administrador. Guarde la configuración por defecto de la url de Jenkins y finalice. Reinicie Jenkins si es necesario.


* Instale los siguientes plugin: HTML Publisher.


* Cree un pipeline. El nombre queda a su elección. En la sección llamada _Pipeline_: la definición del pipeline debe ser _Pipeline script from SCM_; en el campo _SCM_ escoge la opción _Git_; en el campo _Repository URL_ pon la url del repositorio que es _https://github.com/ivanarroyave/dummyapiWitKarateFramework.git_; en la sección que se llama _Branch Specifier (blank for 'any')_ indica la rama que será la referencia para que se ejecute el pipeline, para este caso pon _*/trunk_. Finalmente, aplica los cambios y guarda el pipeline.


* En la raíz del proyecto existe un archivo llamado "Jenkinsfile". Dicho archivo contiene una serie de instrucciones en formato declarativo para que se ejecute el pipeline como código y además se sincroniza con el pipeline creado en Jenkins en pasos previos. Dale un vistazo al contenido:
```
pipeline {
    agent any
	
	tools { 
        gradle 'Gradle 6.9.3' 
    }
	
	options {
		// Keep the 10 most recent builds
		buildDiscarder(logRotator(numToKeepStr:'3'))
		skipStagesAfterUnstable()
	}
	
    stages {
        stage("Test") {
            steps {		
				dir("${env.WORKSPACE}/dummyapiWithKarate"){
					
					sh "gradle clean build -x test"
					
					sh "gradle test --tests *runners.ParallelRunnerTest*"
					
					publishHTML(target: [
						reportName : 'Cucumber with Karate report',
						reportDir:   'dummyapiWitKarate/build/cucumber-html-reports',
						reportFiles: 'overview-features.html',
						keepAll:     true,
						alwaysLinkToLastBuild: true,
						allowMissing: false
					])
				}
			}
        }
    }
}

NOTA: instala Gradle 6.9.3 por medio de Jenkins en las configuraciones globales de herramientas. 

```


* Ahora si, finalmente podrás ejecutar el pipeline. Ingrese al pipeline y acciona la opción _Construir ahora_ todas las veces que lo necesites.


## Autores

* **Iván Darío Arroyave Arboleda** - *Ingeniero de sistemas de información - Especializado en el aseguramiento de la calidad del software* - [ivanarroyave](https://github.com/ivanarroyave)

## Expresiones de Gratitud

* Comenta a otros sobre este proyecto
* Invita una cerveza o un café a alguien del equipo. 
* Da las gracias públicamente.
* etc.
