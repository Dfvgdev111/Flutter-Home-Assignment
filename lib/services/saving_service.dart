import 'package:homeassignment/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingService {
  //Depedency Injection
  SavingService({required SharedPreferences prefs}) : _prefs = prefs;

  late final SharedPreferences _prefs;

  Future<void> savePhoto(Photo photo) async {
    String photoString = '${photo.path}|${photo.title}|${photo.description}';
    List<String>? photoList = _prefs.getStringList("photos") ?? [];

    photoList.add(photoString);

    _prefs.setStringList('photos', photoList);
  }

  Photo makePhotoObject(String photoContents) {
    final parts = photoContents.split('|');
    return Photo(path: parts[0], title: parts[1], description: parts[2]);
  }

  List<Photo> loadPhotos() {
    List<String>? photos = _prefs.getStringList("photos") ?? [];

    List<Photo> listOfTypedPhotos = [];

    for (String photo in photos) {
      listOfTypedPhotos.add(makePhotoObject(photo));
    }

    return listOfTypedPhotos;
  }
}
