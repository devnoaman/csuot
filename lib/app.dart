import 'package:csuot/router/router.dart';
import 'package:csuot/ui/auth/login.dart';
import 'package:csuot/ui/home/home.dart';
import 'package:csuot/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.router.generator,
      home: Splash(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
    );
  }
}
