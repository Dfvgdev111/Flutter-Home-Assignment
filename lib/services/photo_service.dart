import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> takePhoto() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);

    if (picked == null) {
      return null;
    }

    return File(picked.path);
  }

  Future<File> savePhoto(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();

    final String photosPath = '${directory.path}/photos';

    final Directory photosDir = Directory(photosPath);

    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }

    final String fileName = basename(imageFile.path);

    final File savedImage = await imageFile.copy('${photosDir.path}/$fileName');

    print('Savead Picture URI: ${photosDir.uri} Path:${photosDir.path}');

    return savedImage;
  }
}
