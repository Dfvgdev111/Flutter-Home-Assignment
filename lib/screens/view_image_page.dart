import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homeassignment/services/saving_service.dart';
import '../models/photo_model.dart';
import '../widgets/photo_card.dart';

class ViewImagesPage extends StatefulWidget {
  const ViewImagesPage({super.key});

  @override
  State<ViewImagesPage> createState() => _ViewImagesPageState();
}

class _ViewImagesPageState extends State<ViewImagesPage> {
  late final SavingService _savingService;
  late List<Photo> photos;

  @override
  void initState() {
    super.initState();
    _savingService = GetIt.instance<SavingService>();
    photos = _savingService.loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const Center(child: Text('No photos saved yet.'));
    }

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Saved Photos'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return PhotoCard(
            photo: photos[index],
            onRatingChanged: (newRating) async {
              photos[index].rating = newRating;
              await _savingService.updatePhotoRating(index, newRating);

              setState(() {
                photos = _savingService.loadPhotos();
              });
            },
            onDelete: () async {
              await _savingService.deletePhoto(index);

              setState(() {
                photos = _savingService.loadPhotos();
              });
            },
          );
        },
      ),
    );
  }
}
