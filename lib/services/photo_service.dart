import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        return File(photo.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }

  Future<void> savePhoto(File photo, String author, String description) async {
    print(
      'Saving photo: ${photo.path}, Author: $author, Description: $description',
    );
  }
}
