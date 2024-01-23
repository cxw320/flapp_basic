import 'package:flap_basic/modules/home_screen/home_screen_view.dart';
import 'package:flap_basic/navigation/nav_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flap App Basic (No Riverpod)',
      routerConfig: navigationRouter,
    );
  }
}