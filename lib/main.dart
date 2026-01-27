import 'dart:io';
import 'package:flutter/material.dart';
import 'models/photo_model.dart';
import 'widgets/photo_card.dart';
import 'widgets/rating_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Rating Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Photo testPhoto = Photo(path: 'NULL ', author: 'Jahne Doe', rating: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Card Demo')),
      body: Center(
        child: PhotoCard(
          photo: testPhoto,
          onRatingChanged: (newRating) {
            setState(() {
              testPhoto.rating = newRating;
            });
          },
        ),
      ),
    );
  }
}
