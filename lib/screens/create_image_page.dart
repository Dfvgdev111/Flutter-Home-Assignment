import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homeassignment/services/memorynotifcations.dart';
import 'package:homeassignment/services/saving_service.dart';
import '../models/photo_model.dart';
import '../services/photo_service.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateImagePage extends StatefulWidget {
  const CreateImagePage({super.key});

  @override
  State<CreateImagePage> createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _photoService = GetIt.instance<PhotoService>();
  final _savingService = GetIt.instance<SavingService>();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  File? _imageFile;

  //TODO save Images and Save Details

  @override
  void initState() {
    super.initState();

    MemoryNotifcations.initialize();
  }

  void _pickImage() async {
    File? photo = await _photoService.takePhoto();
    if (photo != null) {
      setState(() {
        _imageFile = photo;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      await _photoService.savePhoto(_imageFile!);

      Photo photo = Photo(
        path: _imageFile!.path,
        title: _titleController.text,
        description: _descriptionController.text,
      );

      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _imageFile = null;
      });

      if (await Permission.notification.request().isGranted) {
        await MemoryNotifcations.notficationAlert(
          "Submit Added",
          "Title \"${photo.title}\"",
        );
      }

      await _savingService.savePhoto(photo);

      analytics.logEvent(
        name: "ImageSaved",
        parameters: {
          "Saved Photo": {
            "Title": photo.title,
            "Discription": photo.description,
            "ImagePath": photo.path,
          },
        },
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Photo saved!')));
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a photo first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter an Title'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a description'
                  : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Photo'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 16),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Save Photo Data'),
            ),
          ],
        ),
      ),
    );
  }
}
