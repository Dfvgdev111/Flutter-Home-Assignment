import 'package:homeassignment/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingService {
  //Depedency Injection
  SavingService({required SharedPreferences prefs}) : _prefs = prefs;

  late final SharedPreferences _prefs;

  Future<void> savePhoto(Photo photo) async {
    String photoString = '${photo.path}|${photo.author}|${photo.description}';
    List<String>? photoList = _prefs.getStringList("photos") ?? [];

    photoList.add(photoString);

    _prefs.setStringList('photos', photoList);
  }

  Photo makePhotoObject(String photoContents) {
    final parts = photoContents.split('|');
    return Photo(path: parts[0], author: parts[1], description: parts[2]);
  }

  List<Photo> loadPhotos(List<String> photos) {
    List<Photo> listOfPhotos = [];

    for (String photo in photos) {
      listOfPhotos.add(makePhotoObject(photo));
    }

    return listOfPhotos;
  }
}
