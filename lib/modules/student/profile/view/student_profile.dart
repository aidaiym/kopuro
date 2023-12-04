import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          ),
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Avatar(photo: user.photoUrl),
            const SizedBox(height: 4),
            Text(user.email),
            const SizedBox(height: 4),
            Text(user.username),
          ],
        ),
      ),
    );
  }
}



final FirebaseAuth _auth = FirebaseAuth.instance;

User? getCurrentUser() {
  return _auth.currentUser;
}

Future<Map<String, dynamic>> getUserData(String uid) async {
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userSnapshot.exists) {
      return userSnapshot.data() as Map<String, dynamic>;
    } else {
      return {}; // Return an empty map or handle accordingly
    }
  } catch (e) {
    log('Error fetching user data: $e');
    return {}; // Return an empty map or handle accordingly
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
Future<void> fetchUserData() async {
  User? user = getCurrentUser();

  if (user != null && mounted) {
    String uid = user.uid;

    // Check if the user exists in the Firestore collection
    Map<String, dynamic> data = await getUserData(uid);

    if (mounted) {
      // Check if the widget is still mounted before calling setState
      setState(() {
        userData = data;
      });
    } else {
      // Handle the case where the widget is not mounted
      log('Widget is not mounted. Cannot update state.');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name: ${userData['name']}'),
            Text('Email: ${userData['email']}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
