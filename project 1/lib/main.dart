import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/di/app_providers.dart';
import 'app/routes/app_router.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rating & Reviews',
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
