import 'package:arhibu/features/account_setup/presentation/cubit/profile_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'step1_personalinfo.dart';
import 'step2_location.dart';
import 'step3_lifestyle.dart';
import 'step4_uploadimage.dart';
import 'step5_ammenities.dart';

class AccountSetUp extends StatefulWidget {
  const AccountSetUp({super.key});

  @override
  State<AccountSetUp> createState() => _AccountSetUpState();
}

class _AccountSetUpState extends State<AccountSetUp> {
  int _currentStep = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (_currentStep < 4) {
      setState(() => _currentStep++);
      // Scroll to top when changing steps
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      // Scroll to top when changing steps
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
            child: SvgPicture.asset('images/Vector.svg'),
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
          child: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                      AppBar().preferredSize.height - 
                      MediaQuery.of(context).padding.top,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 5; i++) ...[
                                  _buildStepIndicator(
                                    i == _currentStep
                                        ? "step ${_currentStep + 1}/5"
                                        : "",
                                    isActive: _currentStep >= i,
                                  ),
                                  if (i < 4)
                                    _buildStepConnector(isActive: _currentStep > i),
                                ],
                              ],
                            ),
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
                            if (_currentStep == 4)
                              Step5Ammenities(onNext: _goToNextStep),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
                isActive
                    ? const Color.fromARGB(236, 10, 138, 236)
                    : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  isActive
                      ? const Color.fromARGB(204, 13, 72, 161)
                      : const Color.fromARGB(255, 211, 209, 209),
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              "",
              style: TextStyle(
                color: isActive ? Colors.blue[900] : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
      ],
    );
  }

  Widget _buildStepConnector({bool isActive = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        6,
        (index) => Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
