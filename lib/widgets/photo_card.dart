import 'dart:io';
import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import 'rating_widget.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final Function(int) onRatingChanged;

  const PhotoCard({
    Key? key,
    required this.photo,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: (File(photo.path).existsSync())
                ? Image.file(
                    File(photo.path),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/pictures/sample.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Author: ${photo.author}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: RatingWidget(
              rating: photo.rating,
              onRatingChanged: onRatingChanged,
            ),
          ),
        ],
      ),
    );
  }
}
