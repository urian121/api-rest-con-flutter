import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
    return Scaffold(
      appBar: AppBar(title: const Text('App de Usuarios')),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing:
                      10, // Espacio horizontal entre los elementos
                  mainAxisSpacing: 10, // Espacio vertical entre los elementos
                  childAspectRatio: 0.75, // Ajustar el tamaño de las tarjetas
                ),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1),),
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
                  );
                },
              ),
            ),
    );
  }
}
