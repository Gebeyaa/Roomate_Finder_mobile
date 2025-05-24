import 'package:arhibu/features/account_setup/presentation/cubit/profile_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step1Personalinfo extends StatefulWidget {
  final VoidCallback onNext;

  const Step1Personalinfo({super.key, required this.onNext});

  @override
  State<Step1Personalinfo> createState() => _Step1PersonalinfoState();
}

class _Step1PersonalinfoState extends State<Step1Personalinfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _moveInDateController = TextEditingController();
  final TextEditingController _leaseDurationController =
      TextEditingController();
  final TextEditingController _homeTownController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _aboutYouController = TextEditingController();

  String? _petsPerson;
  String? _gender;
  String? _offeringRoom;
  String? _selectedState = 'Addis Ababa';

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    _budgetController.text = '3000 ETB';
    _moveInDateController.text = 'January 2022';
    _leaseDurationController.text = '6 Month';
    _homeTownController.text = 'Addis Ababa';
    _occupationController.text = 'Student';
    _aboutYouController.text = 'Good Communication';
  }

  @override
  void dispose() {
    _ageController.dispose();
    _budgetController.dispose();
    _moveInDateController.dispose();
    _leaseDurationController.dispose();
    _homeTownController.dispose();
    _occupationController.dispose();
    _aboutYouController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<ProfileSetupCubit>();
      final formData = {
        'state': _selectedState,
        'age': _ageController.text,
        'gender': _gender,
        'offeringRoom': _offeringRoom,
        'budget': _budgetController.text,
        'moveInDate': _moveInDateController.text,
        'leaseDuration': _leaseDurationController.text,
        'petsPerson': _petsPerson,
        'occupation': _occupationController.text,
        'homeTown': _homeTownController.text,
        'aboutYou': _aboutYouController.text,
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
        child: Column(
          children: [
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Here you can tailor your search to the exact neighborhoods you want to live in",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // State dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(),
              ),
              value: _selectedState,
              items:
                  ['Addis Ababa', 'Oromia', 'Amhara', 'Tigray', 'SNNP']
                      .map(
                        (state) =>
                            DropdownMenuItem(value: state, child: Text(state)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your state';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Gender", style: TextStyle(fontSize: 14)),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Female',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Female"),
                          Radio<String>(
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Male"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Are you offering a room for rent?",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Yes',
                  groupValue: _offeringRoom,
                  onChanged: (value) {
                    setState(() {
                      _offeringRoom = value;
                    });
                  },
                ),
                const Text("Yes"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'No',
                  groupValue: _offeringRoom,
                  onChanged: (value) {
                    setState(() {
                      _offeringRoom = value;
                    });
                  },
                ),
                const Text("No"),
              ],
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _budgetController,
              decoration: const InputDecoration(
                labelText: "Maximum rent budget",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your budget';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _moveInDateController,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(255, 243, 234, 234),
                      labelText: "Move in date",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter move-in date';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _leaseDurationController,
                    decoration: const InputDecoration(
                      labelText: "Lease Duration",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter lease duration';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Are you a pets person?",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Yes',
                  groupValue: _petsPerson,
                  onChanged: (value) {
                    setState(() {
                      _petsPerson = value;
                    });
                  },
                ),
                const Text("Yes"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'No',
                  groupValue: _petsPerson,
                  onChanged: (value) {
                    setState(() {
                      _petsPerson = value;
                    });
                  },
                ),
                const Text("No"),
              ],
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _occupationController,
              decoration: const InputDecoration(
                fillColor: Color.fromARGB(255, 243, 234, 234),
                labelText: "Occupation",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your occupation';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _homeTownController,
              decoration: const InputDecoration(
                fillColor: Color.fromARGB(255, 243, 234, 234),
                labelText: "Home Town",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your home town';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _aboutYouController,
              decoration: const InputDecoration(
                fillColor: Color.fromARGB(255, 243, 234, 234),
                labelText: "Brief Information about you",
                border: OutlineInputBorder(),
                hintText: "Tell us something about yourself",
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please tell us about yourself';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),
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
