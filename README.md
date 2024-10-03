# Desglose del Código

### Importaciones:

    import 'dart:convert';
    import 'package:flutter/material.dart';
    import 'package:http/http.dart' as http;

Se importan bibliotecas necesarias: dart:convert para manejar datos JSON, flutter/material.dart para usar widgets de Flutter, y http para hacer solicitudes HTTP.

    Función main():

    void main() {
    runApp(const MyApp());
    }

#### Inicia la aplicación ejecutando el widget MyApp.
Clase MyApp:

    class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de Usuarios',
        theme: ThemeData(
            primarySwatch: Colors.orange,
        ),
        home: const HomePage(),
        );
    }
    }

Define la estructura básica de la aplicación: título, tema y la página de inicio (HomePage).

#### Clase HomePage:

    class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    HomePageState createState() => HomePageState();
    }

**HomePage** es un widget con estado que permite actualizar la UI (Interfaz de Usuario) cuando cambia la lista de usuarios.

#### Estado HomePageState:

    class HomePageState extends State<HomePage> {
    List<dynamic> users = [];

    @override
    void initState() {
        super.initState();
        fetchData();
    }

Se inicializa una lista vacía users para almacenar los datos de los usuarios.
**initState()** llama a **fetchData()** al iniciar el widget.

#### Función fetchData():

    Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.slingacademy.com/v1/sample-data/users'));
    if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
        users = data['users'];
        });
    }
    }

Hace una solicitud GET a la API para obtener datos de usuarios.
Si la respuesta es exitosa (statusCode == 200), convierte el cuerpo de la respuesta de JSON a un objeto de Dart y actualiza la lista users utilizando setState(), lo que reconstruye la UI.

#### Construcción de la UI:

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('App de Usuarios')),
        body: users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['profile_picture']),
                    ),
                    title: Text('${user['first_name']} ${user['last_name']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${user['email']}'),
                        Text('Teléfono: ${user['phone']}'),
                        Text('Ciudad: ${user['city']}, ${user['state']}, ${user['country']}'),
                        Text('Trabajo: ${user['job']}'),
                        Text('Fecha de Nacimiento: ${user['date_of_birth'].substring(0, 10)}'),
                      ],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Usuario ${user['first_name']} ${user['last_name']} seleccionado')),
                      );
                    },
                  );
                },
              ),
      );
    }

Muestra un **AppBar** con el título de la aplicación.
Si users está vacío, muestra un indicador de carga **(CircularProgressIndicator)**.
Si hay usuarios, utiliza un ListView.builder para crear una lista de **ListTile** que muestra información de cada usuario.
Al hacer clic en un **ListTile**, se muestra un **SnackBar** con el nombre del usuario seleccionado.

#### Resumen

Este código crea una aplicación **Flutter** que obtiene datos de usuarios de una **API**, los muestra en una lista, y permite ver detalles de cada usuario al hacer clic en ellos. Utiliza las funciones **http** para la solicitud y **json** para manejar la respuesta.