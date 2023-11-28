import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(), 
      child: const KopuroApp(),
    );
  }
}

// class KopuroApp extends StatelessWidget {
//   const KopuroApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//           DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     Users? user = Users.fromJson(userDoc.data()!);
//     return MaterialApp(
//             title: 'KopuroApp',
//             debugShowCheckedModeBanner: false,
//             onGenerateRoute: (settings) {
//               return AppRouter.onGenerateRoute(settings, user);
//             },
//     );
//   }
// }

//  final FirebaseAuth _auth = FirebaseAuth.instance;
     
//         Users? userDetails = await getUserDetailsFromFirestore(user.uid)=  await FirebaseFirestore.instance.collection('users').doc(uid).get();
// //           Users.fromJson(userDoc.data()!);
  


class KopuroApp extends StatelessWidget {
  const KopuroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: context.read<AuthCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users? user = snapshot.data;
          return MaterialApp(
            title: 'KopuroApp',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              return AppRouter.onGenerateRoute(settings, user);
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

