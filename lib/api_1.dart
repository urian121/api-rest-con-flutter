import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Libros',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const BookListPage(),
    );
  }
}

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  final List<Map<String, String>> bookLists = const [
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/083/9786160839568L.jpg?h=e80c4422dbdc45a308a04163c7517d8c",
      "title": "Desarrollo de aplicaciones web con Python Django",
      "price": "325"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/083/9786160833313L.jpg?h=943250c85d4baee198274f0b5e36c956",
      "title": "Programación en Swift y iOS básico",
      "price": "295"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/083/9786160837809L.jpg?h=d067f4638ee6d036c6a5f21659b64222",
      "title": "Desarrollo de aplicaciones móviles en Android con Kotlin",
      "price": "300"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/083/9786160831869L.jpg?h=c03e00d82ae11f8f133c533c1a3d9323",
      "title": "Programación en Java para principiantes",
      "price": "350"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/083/9786160839063L.jpg?h=65a8d390c5bad3564bcbee3ba4d81ca0",
      "title": "Aprender a programar a través de juegos",
      "price": "199"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/082/9786160822195L.jpg?h=90ec7639d0785002a1e8522b607ba5c6",
      "title": "Desarrollo de aplicaciones web con PHP, MySQL y JQuery",
      "price": "330"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/081/9786160818792L.jpg?h=372442301a6a33b37ba6311be7e0e660",
      "title": "Creación de sitios web con HTML5, CSS3 y JQuery",
      "price": "440"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978047/019/9780470197684L.gif?h=9782737c617a005a72eb1f8e32b522e1",
      "title": "Finanzas corporativas",
      "price": "500"
    },
    {
      "image":
          "https://images-se-ed.com/ws/Storage/Originals/978616/706/9786167060316L.jpg?h=a5bc0e04ff8326c7f5884183fd7f4230",
      "title": "Contabilidad financiera",
      "price": "199"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Libros'.toUpperCase()),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bookLists.length,
        itemBuilder: (context, index) {
          return BookItemCard(
            imageUrl: bookLists[index]['image']!,
            title: bookLists[index]['title']!,
            price: bookLists[index]['price']!,
          );
        },
      ),
    );
  }
}

class BookItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const BookItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$price COP',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Chip(
              label: Text(
                'Oferta',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              backgroundColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
