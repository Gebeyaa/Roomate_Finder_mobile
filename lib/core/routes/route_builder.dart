import 'package:arhibu/features/account_setup/presentation/bloc/account_setup_bloc.dart';
import 'package:arhibu/features/account_setup/presentation/screens/account_setup_screen.dart';
import 'package:arhibu/features/account_setup/presentation/screens/step2_location.dart';
import 'package:arhibu/features/auth/presentation/bloc/login_bloc.dart';
import 'package:arhibu/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:arhibu/features/auth/presentation/screens/getstarted_screen.dart';
import 'package:arhibu/features/auth/presentation/screens/login_screen.dart';
import 'package:arhibu/features/auth/presentation/screens/signup_screen.dart';
import 'package:arhibu/features/home/presentation/screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/account_setup/presentation/cubit/profile_setup_cubit.dart';
import 'route_names.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RouteNames.signup:
          (context) => BlocProvider(
            create: (context) => SignupBloc(),
            child: const SignupScreen(),
          ),
      RouteNames.login:
          (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginScreen(),
          ),

      RouteNames.getstarted:
          (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const GetstartedScreen(),
          ),
      RouteNames.home:
          (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const HomePageScreen(),
          ),
      RouteNames.accountsetup:
          (context) => BlocProvider(
            create: (context) => AccountSetupBloc(),
            child: const AccountSetUp(),
          ),
      RouteNames.step2:
          (context) => BlocProvider(
            create: (_) => ProfileSetupCubit(),
            child: const Step2Location(),
          ),
      
    };
  }
}

// AccountSetupAppBar
