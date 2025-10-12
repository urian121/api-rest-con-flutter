# 🧩 API con Flutter

### 📦 Importaciones
```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
```
- `dart:convert`: para manejar JSON  
- `flutter/material.dart`: widgets de Flutter  
- `http`: para solicitudes a la API  

---

### 🚀 Función principal
```dart
void main() => runApp(const MyApp());
```
Inicia la app ejecutando el widget **MyApp**.

---

### 🧱 Clase MyApp
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de Usuarios',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const HomePage(),
      );
}
```
Define el título, tema y pantalla principal (**HomePage**).

---

### 👥 Clase HomePage
```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}
```
Widget con estado para actualizar la interfaz al recibir datos.

---

### 🔄 Estado HomePageState
```dart
class HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
```
Inicializa una lista vacía y llama a `fetchData()` al cargar el widget.

---

### 🌐 Obtener datos de la API
```dart
Future<void> fetchData() async {
  final res = await http.get(Uri.parse('https://api.slingacademy.com/v1/sample-data/users'));
  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    setState(() => users = data['users']);
  }
}
```
Hace una solicitud **GET** y actualiza la lista `users` con los datos recibidos.

---

### 🖥️ Construcción de la UI
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('App de Usuarios')),
    body: users.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) {
              final u = users[i];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(u['profile_picture'])),
                title: Text('${u['first_name']} ${u['last_name']}'),
                subtitle: Text('Email: ${u['email']}'),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Usuario ${u['first_name']} seleccionado')),
                ),
              );
            },
          ),
  );
}
```
Muestra un **loader** si no hay datos y una lista de usuarios cuando la API responde.

---

### ✅ Resumen
App Flutter que:
- Consume una API pública  
- Muestra usuarios en una lista  
- Usa `http` y `json` para manejar datos  
- Actualiza la UI con `setState()`  
