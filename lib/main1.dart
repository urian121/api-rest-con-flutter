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
                    // Al hacer clic en un ListTile, se muestra un SnackBar con el nombre del usuario seleccionado.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Usuario ${user['first_name']} ${user['last_name']} seleccionado')),
                    );
                  },
                );
              },
            ),
    );
  }
}
