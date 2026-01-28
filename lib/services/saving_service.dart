import 'dart:io';

import 'package:homeassignment/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingService {
  //Depedency Injection
  SavingService({required SharedPreferences prefs}) : _prefs = prefs;

  late final SharedPreferences _prefs;

  Future<void> savePhoto(Photo photo) async {
    String photoString = makePhotoString(photo);
    List<String>? photoList = _prefs.getStringList("photos") ?? [];

    photoList.add(photoString);

    _prefs.setStringList('photos', photoList);
  }

  Future<void> savePhotos(List<Photo> photos) async {
    final photoStrings = photos.map((p) => makePhotoString(p)).toList();
    print(photoStrings);
    await _prefs.setStringList('photos', photoStrings);
  }

  Photo makePhotoObject(String photoContents) {
    final parts = photoContents.split('|');
    return Photo(
      path: parts[0],
      title: parts[1],
      description: parts[2],
      rating: int.parse(parts[3]),
    );
  }

  String makePhotoString(Photo photo) {
    return '${photo.path}|${photo.title}|${photo.description}|${photo.rating}';
  }

  List<Photo> loadPhotos() {
    List<String>? photos = _prefs.getStringList("photos") ?? [];

    List<Photo> listOfTypedPhotos = [];

    for (String photo in photos) {
      listOfTypedPhotos.add(makePhotoObject(photo));
    }

    return listOfTypedPhotos;
  }

  Future<void> updatePhotoRating(int index, int rating) async {
    var photos = loadPhotos();
    if (index < 0 || index >= photos.length) return;

    photos[index].rating = rating;

    await savePhotos(photos);
    print("Saving is done");
  }

  Future<void> deletePhoto(int index) async {
    List<Photo> photos = loadPhotos();

    final photo = photos[index];

    final file = File(photo.path);

    if (await file.exists()) {
      await file.delete();
    }
    photos.removeAt(index);

    await savePhotos(photos);

    print('Deleting at index $index');
  }
}
