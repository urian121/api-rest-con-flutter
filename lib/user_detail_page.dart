import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final dynamic user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${user['first_name']} ${user['last_name']}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user['profile_picture']),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre: ${user['first_name']} ${user['last_name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Email: ${user['email']}'),
            Text('Teléfono: ${user['phone']}'),
            Text('Trabajo: ${user['job']}'),
            Text('Ciudad: ${user['city']}'),
            Text('Estado: ${user['state']}'),
            Text('País: ${user['country']}'),
            Text('Código Postal: ${user['zipcode']}'),
            Text(
                'Fecha de Nacimiento: ${user['date_of_birth'].substring(0, 10)}'),
          ],
        ),
      ),
    );
  }
}
