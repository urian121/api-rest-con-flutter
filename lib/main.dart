import 'dart:convert'; //para manejar datos JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // para hacer solicitudes HTTP
import 'user_detail_page.dart'; // Importa la nueva página aquí

// Inicia la aplicación ejecutando el widget MyApp
void main() {
  runApp(const MyApp());
}

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

// HomePage es un widget con estado que permite actualizar la UI (Interfaz de Usuario) cuando cambia la lista de usuarios.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Se inicializa una lista vacía users para almacenar los datos de los usuarios.
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    // initState() llama a fetchData() al iniciar el widget.
    fetchData();
  }


 // Hace una solicitud GET a la API para obtener datos de usuarios.
 // Si la respuesta es exitosa (statusCode == 200), convierte el cuerpo de la respuesta de JSON
 // a un objeto de Dart y actualiza la lista users utilizando setState(), lo que reconstruye la UI.
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://api.slingacademy.com/v1/sample-data/users'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        users = data['users'];
      });
    } else {
      //print('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2,);
    return Scaffold(
      appBar: AppBar(title: const Text('App de Usuarios', style: textStyle,)),
      // Si users está vacío, muestra un indicador de carga (CircularProgressIndicator).
      // Si hay usuarios, utiliza un ListView.builder para crear una lista de ListTile que muestra información de cada usuario.
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 10, // Espacio horizontal entre los elementos
                  mainAxisSpacing: 10, // Espacio vertical entre los elementos
                  childAspectRatio: 0.85, // Ajustar el tamaño de las tarjetas
                ),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return GestureDetector(
                    // Evento de clic en un ListTile
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailPage(user: user),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(user['profile_picture']),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${user['first_name']} ${user['last_name']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(user['job']),
                          const SizedBox(height: 5),
                          Text(
                            'Fecha: ${user['date_of_birth'].substring(0, 10)}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
