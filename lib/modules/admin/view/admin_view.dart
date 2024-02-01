import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});
    static Page<void> page() =>
      const MaterialPage<void>(child: AdminView());
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Admin'),
    );
  }
}