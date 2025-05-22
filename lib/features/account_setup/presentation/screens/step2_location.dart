import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_setup_cubit.dart';
import 'step_indicators.dart';

class Step2Location extends StatefulWidget {
   final VoidCallback onNext;
  
  const Step2Location({super.key, required this.onNext});

  @override
  State<Step2Location> createState() => _Step2LocationState();
}

class _Step2LocationState extends State<Step2Location> {
  String? selectedCity;
  final List<String> cities = [
    'Minna-Niger State',
    'Lagos',
    'Abuja',
    'Port Harcourt',
    'Kano',
  ];

  final List<String> neighborhoods = [
    'Cidan Kwano',
    'Bosso',
    'Chanchaga',
    'GRA',
    'Tunga',
    'Kpakungu',
    'Maikunkele',
    'Shango',
    'Dutsen Kura',
  ];

  final Map<String, bool> selectedNeighborhoods = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var neighborhood in neighborhoods) {
      selectedNeighborhoods[neighborhood] = false;
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (selectedNeighborhoods.containsValue(true)) {
        final cubit = context.read<ProfileSetupCubit>();

        cubit.updateFormData({
          'city': selectedCity,
          'neighborhoods':
              selectedNeighborhoods.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList(),
        });
widget.onNext();
        cubit.nextStep();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one neighborhood'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            // Step indicator
            const StepIndicator(currentStep: 2, totalSteps: 5),

            // Title and divider
            const Text(
              'Neighborhood Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.grey, thickness: 1, height: 20),
            const SizedBox(height: 16),

            // City dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select your city',
                border: OutlineInputBorder(),
              ),
              value: selectedCity,
              items:
                  cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your city';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Neighborhood selection
            const Text(
              'Select your preferred neighborhoods:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Neighborhood checkboxes
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  neighborhoods.map((neighborhood) {
                    return CheckboxListTile(
                      title: Text(neighborhood),
                      value: selectedNeighborhoods[neighborhood],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedNeighborhoods[neighborhood] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => _submitForm(context),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
