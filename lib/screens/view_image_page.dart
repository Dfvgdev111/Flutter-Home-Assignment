import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homeassignment/services/saving_service.dart';
import '../models/photo_model.dart';
import '../widgets/photo_card.dart';

class ViewImagesPage extends StatelessWidget {
  const ViewImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _savingService = GetIt.instance<SavingService>();

    // Load saved photos from SharedPreferences
    final List<Photo> photos = _savingService.loadPhotos();

    if (photos.isEmpty) {
      return const Center(child: Text('No photos saved yet.'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Photos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return PhotoCard(
            photo: photos[index],
            onRatingChanged: (newRating) {},
          );
        },
      ),
    );
  }
}
