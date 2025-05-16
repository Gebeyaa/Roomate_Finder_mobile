import 'package:arhibu/features/auth/presentation/bloc/login_bloc.dart';
import 'package:arhibu/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:arhibu/features/auth/presentation/screens/login_screen.dart';
import 'package:arhibu/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    };
  }
}
