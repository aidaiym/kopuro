import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class KopuroApp extends StatelessWidget {
  const KopuroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'KopuroApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}