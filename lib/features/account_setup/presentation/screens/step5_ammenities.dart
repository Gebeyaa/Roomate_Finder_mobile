import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_setup_cubit.dart';

class Step5Ammenities extends StatefulWidget {
  final VoidCallback onNext;
  const Step5Ammenities({super.key, required this.onNext});
  @override
  State<Step5Ammenities> createState() => _Step5AmmenitiesState();
}

class _Step5AmmenitiesState extends State<Step5Ammenities> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, bool> _amenities = {
    'Running Water': false,
    'Electricity': false,
    'Swimming pool': false,
    'Washer': false,
  };
  final TextEditingController _cityController = TextEditingController(
    text: 'Addis Ababa',
  );
  final TextEditingController _subCityController = TextEditingController(
    text: 'Guiele',
  );
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _furnitureController = TextEditingController(
    text: 'Fully furnitured',
  );
  final TextEditingController _apartmentTypeController = TextEditingController(
    text: 'Bungalow',
  );
  final TextEditingController _descriptionController = TextEditingController();

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number <= 0) {
      return 'Number must be greater than 0';
    }
    if (number > 10) {
      return 'Number cannot be greater than 10';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please provide a description';
    }
    if (value.trim().length < 20) {
      return 'Description must be at least 20 characters long';
    }
    if (value.trim().length > 500) {
      return 'Description cannot exceed 500 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _cityController.dispose();
    _subCityController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _furnitureController.dispose();
    _apartmentTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration _getInputDecoration({String? hintText}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      isDense: true,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ProfileSetupCubit>();

      final selectedAmenities =
          _amenities.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

      final formData = {
        'room_city': _cityController.text,
        'room_subcity': _subCityController.text,
        'bedrooms': _bedroomsController.text,
        'bathrooms': _bathroomsController.text,
        'furniture': _furnitureController.text,
        'apartment_type': _apartmentTypeController.text,
        'description': _descriptionController.text,
        'amenities': selectedAmenities,
      };
      cubit.updateFormData(formData);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      cubit
          .submitProfile()
          .then((_) {
            Navigator.of(context).pop();
            if (cubit.state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              widget.onNext();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    cubit.state.errorMessage ?? 'An unknown error occurred',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          })
          .catchError((error) {
            // Hide loading indicator
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${error.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Room Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 73, 27, 27),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You Can setup here what type of room you need',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            const Text(
              'Where do you like your room to be located located?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _cityController,
              decoration: _getInputDecoration(),
              style: const TextStyle(fontSize: 16),
              validator: _validateRequired,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            const Text(
              'Which sub city do you prefer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _subCityController,
              decoration: _getInputDecoration(),
              style: const TextStyle(fontSize: 16),
              validator: _validateRequired,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            const Text(
              'Total Number of Bedrooms you want',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bedroomsController,
              decoration: _getInputDecoration(
                hintText: 'Enter number of bedrooms',
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
              validator: _validateNumber,
            ),
            const SizedBox(height: 16),

            const Text(
              'Total Number of Bathrooms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bathroomsController,
              decoration: _getInputDecoration(
                hintText: 'Enter number of bathrooms',
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
              validator: _validateNumber,
            ),
            const SizedBox(height: 16),

            const Text(
              'Furniture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _furnitureController,
              decoration: _getInputDecoration(),
              style: const TextStyle(fontSize: 16),
              validator: _validateRequired,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            const Text(
              'Apartment type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _apartmentTypeController,
              decoration: _getInputDecoration(),
              style: const TextStyle(fontSize: 16),
              validator: _validateRequired,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),

            const Text(
              'Amenities Available in the House',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _amenities['Running Water'],
                  onChanged: (bool? value) {
                    setState(() {
                      _amenities['Running Water'] = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Running Water',
                  style: TextStyle(
                    color:
                        _amenities['Running Water'] == true
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Checkbox(
                  value: _amenities['Electricity'],
                  onChanged: (bool? value) {
                    setState(() {
                      _amenities['Electricity'] = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Electricity',
                  style: TextStyle(
                    color:
                        _amenities['Electricity'] == true
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: _amenities['Swimming pool'],
                  onChanged: (bool? value) {
                    setState(() {
                      _amenities['Swimming pool'] = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Swimming pool',
                  style: TextStyle(
                    color:
                        _amenities['Swimming pool'] == true
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Checkbox(
                  value: _amenities['Washer'],
                  onChanged: (bool? value) {
                    setState(() {
                      _amenities['Washer'] = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Washer',
                  style: TextStyle(
                    color:
                        _amenities['Washer'] == true
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(height: 40, thickness: 1),

            const Text(
              'Brief Information About room you are looking for',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              decoration: _getInputDecoration(
                hintText:
                    'Enter description about the room you are looking for',
              ),
              maxLines: 4,
              style: const TextStyle(fontSize: 14),
              validator: _validateDescription,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),

            const Divider(height: 40, thickness: 1),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _submitForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Complete Account Set Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
