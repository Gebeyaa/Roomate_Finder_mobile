import 'package:arhibu/core/routes/app_router.dart';
import 'package:arhibu/core/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arhibu',
      initialRoute: RouteNames.getstarted,
      onGenerateRoute: AppRouter.generateRoute,
      theme: AppTheme.lightTheme,
    );
  }
}
