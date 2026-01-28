import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homeassignment/services/saving_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/photo_model.dart';
import '../services/photo_service.dart';

class CreateImagePage extends StatefulWidget {
  const CreateImagePage({super.key});

  @override
  State<CreateImagePage> createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final PhotoService _photoService = PhotoService();
  SavingService? _savingService;

  File? _imageFile;

  //TODO save Images and Save Details

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

      _authorController.clear();
      _descriptionController.clear();
      setState(() {
        _imageFile = null;
      });

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
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter an author'
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
