import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arhibu/features/account_setup/presentation/cubit/profile_setup_cubit.dart';

class Step3Lifestyle extends StatefulWidget {
  final VoidCallback onNext;
  
  const Step3Lifestyle({super.key, required this.onNext});

  @override
  State<Step3Lifestyle> createState() => _Step3LifestyleState();
}

class _Step3LifestyleState extends State<Step3Lifestyle> {
  String? _cleanliness;
  String? _workHours;
  String? _sleepHours;
  String? _tobaccoRelationship;
  String? _alcoholRelationship;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ProfileSetupCubit>();

      // Collect all form data
      final formData = {
        'cleanliness': _cleanliness,
        'workHours': _workHours,
        'sleepHours': _sleepHours,
        'tobaccoRelationship': _tobaccoRelationship,
        'alcoholRelationship': _alcoholRelationship,
      };

      cubit.updateFormData(formData);

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
            // Step indicator
            const Text(
              "Step 3/5",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Lifestyle Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.grey, thickness: 1, height: 20),
            const SizedBox(height: 23),

            _buildQuestionDropdown(
              question: "How would you describe your cleanliness?",
              value: _cleanliness,
              items: const [
                "I am very clean",
                "I am moderately clean",
                "I don't focus much on cleanliness",
              ],
              onChanged: (value) {
                setState(() {
                  _cleanliness = value;
                });
              },
              validator: (value) => value == null ? 'Please select an option' : null,
            ),
            const SizedBox(height: 24),

            _buildQuestionDropdown(
              question: "How would you describe your school/work hours?",
              value: _workHours,
              items: const [
                "Regular daytime hours",
                "Evening/night shifts",
                "Irregular schedule",
                "Student hours",
              ],
              onChanged: (value) {
                setState(() {
                  _workHours = value;
                });
              },
              validator: (value) => value == null ? 'Please select an option' : null,
            ),
            const SizedBox(height: 24),

            _buildQuestionDropdown(
              question: "How would you describe your sleeping hours?",
              value: _sleepHours,
              items: const [
                "Early to bed, early to rise",
                "Night owl",
                "Irregular sleep pattern",
                "Light sleeper",
              ],
              onChanged: (value) {
                setState(() {
                  _sleepHours = value;
                });
              },
              validator: (value) => value == null ? 'Please select an option' : null,
            ),
            const SizedBox(height: 24),

            _buildQuestionDropdown(
              question: "How would you describe your relationship with tobacco?",
              value: _tobaccoRelationship,
              items: const [
                "Non-smoker",
                "Social smoker",
                "Regular smoker",
                "Trying to quit",
              ],
              onChanged: (value) {
                setState(() {
                  _tobaccoRelationship = value;
                });
              },
              validator: (value) => value == null ? 'Please select an option' : null,
            ),
            const SizedBox(height: 24),

            _buildQuestionDropdown(
              question: "How would you describe your relationship with alcohol?",
              value: _alcoholRelationship,
              items: const [
                "Non-drinker",
                "Social drinker",
                "Regular drinker",
                "Sober",
              ],
              onChanged: (value) {
                setState(() {
                  _alcoholRelationship = value;
                });
              },
              validator: (value) => value == null ? 'Please select an option' : null,
            ),
            const SizedBox(height: 40),

            // Next button
            ElevatedButton(
              onPressed: () => _submitForm(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionDropdown({
    required String question,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          hint: const Text("Select an option"),
        ),
      ],
    );
  }
}