import 'package:arhibu/features/account_setup/presentation/cubit/profile_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'step1_personalinfo.dart';
import 'step2_location.dart';
import 'step3_lifestyle.dart';
import 'step4_uploadimage.dart';

class AccountSetUp extends StatefulWidget {
  const AccountSetUp({super.key});

  @override
  State<AccountSetUp> createState() => _AccountSetUpState();
}

class _AccountSetUpState extends State<AccountSetUp> {
  int _currentStep = 0;

  void _goToNextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileSetupCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/realogo.png'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.menu, color: Colors.blue, size: 32),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromARGB(80, 243, 106, 236), Colors.white],
              stops: [0.05, 0.3],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentStep > 0)
                    GestureDetector(
                      onTap: _goToPreviousStep,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  Column(
                    children: [
                      Text(
                        "Set up your account to find roommate/room",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 73, 27, 27),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Hollai, Fill in the details to complete sign up',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          _buildStepIndicator(
                            1,
                            "",
                            isActive: _currentStep >= 0,
                          ),
                          _buildStepConnector(isActive: _currentStep >= 1),
                          _buildStepIndicator(
                            2,
                            "",
                            isActive: _currentStep >= 1,
                          ),
                          _buildStepConnector(isActive: _currentStep >= 2),
                          _buildStepIndicator(
                            3,
                            "",
                            isActive: _currentStep >= 2,
                          ),
                          _buildStepConnector(isActive: _currentStep >= 3),
                          _buildStepIndicator(
                            4,
                            "",
                            isActive: _currentStep >= 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_currentStep == 0)
                          Step1Personalinfo(onNext: _goToNextStep),
                        if (_currentStep == 1)
                          Step2Location(onNext: _goToNextStep),
                        if (_currentStep == 2)
                          Step3Lifestyle(onNext: _goToNextStep),
                        if (_currentStep == 3)
                          Step4UploadImage(onNext: _goToNextStep),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(
    int stepNumber,
    String label, {
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector({bool isActive = false}) {
    return Expanded(
      child: Container(
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: isActive ? Colors.blue : Colors.grey[300],
      ),
    );
  }
}
