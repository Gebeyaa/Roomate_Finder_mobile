import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arhibu/features/account_setup/presentation/screens/account_setup_screen.dart';
import 'package:arhibu/features/account_setup/presentation/cubit/profile_setup_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileSetupCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
          builder: (context, state) {
            if (state.isProfileComplete) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Profile Setup Complete!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text('Your profile information will be displayed here.'),
                  ],
                ),
              );
            } else {
              return const AccountSetupScreen();
            }
          },
        ),
      ),
    );
  }
} 