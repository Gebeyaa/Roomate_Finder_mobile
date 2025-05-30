import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_setup_cubit.dart';

class Step2Location extends StatefulWidget {
  final VoidCallback onNext;

  const Step2Location({super.key, required this.onNext});

  @override
  State<Step2Location> createState() => _Step2LocationState();
}

class _Step2LocationState extends State<Step2Location> {
  String? selectedCity;
  final List<String> cities = ['Addis Ababa'];

  final List<String> neighborhoods = [
    'Bole',
    'Kazanchis',
    'Piassa',
    'Arat Kilo',
    'Megenagna',
    'Gullele',
    'Lideta',
    'Kirkos',
    'Yeka',
    'Nifas Silk-Lafto',
    'Akaki Kality',
    'Kolfe Keranio',
    'Goro',
    'Summit',
    'CMC',
    'Saris',
    'Ayat',
    'Lafto',
    'Gotera',
    'Mexico',
    'Gurd Shola',
    'Jemo',
    'Tor Hailoch',
    'Legetafo',
    'Addisu Gebeya',
    'Shola',
    'Senga Tera',
    'Merkato',
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

            const Text(
              'Neighborhood Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 73, 27, 27),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Color.fromARGB(255, 196, 194, 194),
              thickness: 1,
              height: 20,
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select your city'),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(),
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
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              'Select your preferred neighborhoods:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
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
                      activeColor: Colors.blue,
                    );
                  }).toList(),
            ),

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
