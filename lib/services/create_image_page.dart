import 'package:flutter/material.dart';
import '../models/photo_model.dart';

class CreateImagePage extends StatefulWidget {
  const CreateImagePage({super.key});

  @override
  State<CreateImagePage> createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Photo newPhoto = Photo(
        path: '',
        author: _authorController.text,
        description: _descriptionController.text,
        rating: 0,
      );

      //TODO Have to implement a service to for saving
      print(
        'Photo ready to save: Author=${newPhoto.author}, Description=${newPhoto.description}',
      );

      _authorController.clear();
      _descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo data saved (image pending)')),
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
          mainAxisAlignment: MainAxisAlignment.center,
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
