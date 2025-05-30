import 'dart:io';

import 'package:arhibu/features/account_setup/presentation/cubit/profile_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Step4UploadImage extends StatefulWidget {
  final VoidCallback onNext;

  const Step4UploadImage({super.key, required this.onNext});

  @override
  State<Step4UploadImage> createState() => _Step4UploadImageState();
}

class _Step4UploadImageState extends State<Step4UploadImage> {
  final List<File> _uploadedImages = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        if (_uploadedImages.length < 6) {
          _uploadedImages.add(file);
          _selectedImage = file;
        }
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ProfileSetupCubit>();
      cubit.updateFormData({'uploadedImages': _uploadedImages});
      widget.onNext();
      cubit.nextStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Upload profile images",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 73, 27, 27),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "You can upload a minimum of 1 and maximum of 6 pictures.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.grey, thickness: 1, height: 20),
            const SizedBox(height: 32),

            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),

                child:
                    _selectedImage == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 48,
                              color: Colors.blue.withOpacity(0.6),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Tap here to upload your profile images.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 24),

            if (_uploadedImages.isNotEmpty) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: _uploadedImages.length,
                itemBuilder: (context, index) {
                  final file = _uploadedImages[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = file;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  _selectedImage == file
                                      ? Colors.blue
                                      : Colors.grey[300]!,
                              width: _selectedImage == file ? 2 : 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              file,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap:
                              () => setState(() {
                                if (_selectedImage == file) {
                                  _selectedImage = null;
                                }
                                _uploadedImages.removeAt(index);
                              }),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                "${_uploadedImages.length}/6 photos uploaded",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
            ],

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
                _uploadedImages.isNotEmpty ? () => _submitForm(context) : null;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _uploadedImages.isNotEmpty ? Colors.blue : Colors.grey[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                textStyle: const TextStyle(fontSize: 16),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
