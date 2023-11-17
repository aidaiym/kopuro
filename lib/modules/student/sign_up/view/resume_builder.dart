import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopuro/app/router/app_router.dart';
import 'package:kopuro/models/user/user_model.dart';

import '../../../../components/components.dart';
import '../../../../constants/contants.dart';
import '../../../modules.dart';

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final dateOfBirthController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final educationController = TextEditingController();
    final skillsController = TextEditingController();
    final linkedinController = TextEditingController();
    final githubController = TextEditingController();
    final aboutController = TextEditingController();
    final jobController = TextEditingController();
    final languageController = TextEditingController();
    final locationController = TextEditingController();
    File? selectedImage;
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.isSuccess) {}
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final pickedImage = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (pickedImage != null) {
                            selectedImage = File(pickedImage.path);
                          }
                        },
                        child: const Text('Choose Photo'),
                      ),
                      if (selectedImage != null)
                        Image.file(
                          selectedImage!,
                          width: 100,
                          height: 100,
                        ),
                      TextFieldWidget(
                        controller: nameController,
                        label: 'Аты-жөнү',
                        validator: 'Сураныч, Аты-жөнү жазыныз',
                        description: 'Аты-жөнү',
                      ),
                      TextFieldWidget(
                        controller: dateOfBirthController,
                        label: 'Туулган күн',
                        validator: 'Сураныч, Туулган күн жазыныз',
                        description: 'Туулган күн',
                      ),
                      TextFieldWidget(
                        controller: phoneNumberController,
                        label: 'Телефон номери',
                        validator: 'Сураныч, Телефон номери жазыныз',
                        description: 'Телефон номери',
                      ),
                      TextFieldWidget(
                        controller: locationController,
                        label: 'Жайгашкан жери',
                        validator: 'Сураныч, Жайгашкан жери жазыныз',
                        description: 'Жайгашкан жери',
                      ),
                      TextFieldWidget(
                        controller: aboutController,
                        label: 'мен тууралуу',
                        validator: 'Сураныч, мен тууралуу жазыныз',
                        description: 'мен тууралуу',
                      ),
                      TextFieldWidget(
                        controller: jobController,
                        label: 'Жумуштун аталышы',
                        validator: 'Сураныч, жумуштун жазыныз',
                        description: 'Жумуштун аталышы',
                      ),
                      Text(
                        'Профессионалдык Кыскача маалымат',
                        style: AppTextStyles.header2,
                      ),
                      TextFieldWidget(
                        controller: educationController,
                        label: 'билим',
                        validator: 'Сураныч, билим жазыныз',
                        description: 'билим',
                      ),
                      TextFieldWidget(
                        controller: jobController,
                        label: 'иш тажрыйба',
                        validator: 'Сураныч, иш тажрыйба жазыныз',
                        description: 'иш тажрыйба',
                      ),
                      TextFieldWidget(
                        controller: skillsController,
                        label: 'көндүмдөр',
                        validator: 'Сураныч, көндүмдөр жазыныз',
                        description: 'көндүмдөр',
                      ),
                      TextFieldWidget(
                        controller: languageController,
                        label: 'тил',
                        validator: 'Сураныч, тил жазыныз',
                        description: 'тил',
                      ),
                      TextFieldWidget(
                        controller: linkedinController,
                        label: 'Linkedin',
                        validator: 'Сураныч, Linkedin жазыныз',
                        description: 'Linkedin',
                      ),
                      TextFieldWidget(
                        controller: githubController,
                        label: 'Github',
                        validator: 'Сураныч, Github жазыныз',
                        description: 'Github',
                      ),
                       MainButton(
                        onPressed: () async {
                          final userCubit =
                              BlocProvider.of<SignUpCubit>(context);
                          final user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            final users = Users(
                              uid: user.uid,
                              createdTime: DateTime.now(),
                              userType: 'Student',
                              email: user.email!,
                              username: nameController.text,
                              phoneNumber: phoneNumberController.text,
                              aboutUser: aboutController.text,
                              jobTitle: jobController.text,
                              skills: skillsController.text,
                              userLocation: locationController.text,
                              education: educationController.text,
                              workExperience: jobController.text,
                              language: languageController.text,
                              linkedIn: linkedinController.text,
                              github: githubController.text,
                              photoUrl: selectedImage?.path ?? '', 
                            );

                            userCubit.createStudent(users);

                            final state = userCubit.state;
                            if (state.isSuccess) {
                              if (selectedImage != null) {
                                final storageReference =
                                    FirebaseStorage.instance.ref().child(
                                        'user_photos/${user.uid}/${DateTime.now().toString()}');
                                final uploadTask =
                                    storageReference.putFile(selectedImage!);
                                await uploadTask.whenComplete(() async {
                                  final downloadURL =
                                      await storageReference.getDownloadURL();
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .update({'photoUrl': downloadURL});
                                });
                              }

                              Navigator.pushNamed(
                                  context, AppRouter.studentMainView);
                            } else {
                              // Handle user creation failure if needed
                              print('User creation failed');
                            }
                          } else {
                            print('No signed-in user');
                          }
                        },
                        text: 'Катталуу',
                      ),
                      if (state.errorMessage.isNotEmpty)
                        Text(
                          'Error: ${state.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}





//                       MainButton(
//                         onPressed: () async {
//                           final userCubit =
//                               BlocProvider.of<SignUpCubit>(context);
//                           final user = FirebaseAuth.instance.currentUser;

//                           if (user != null) {
//                             final users = Users(
//                               uid: user.uid,
//                               createdTime: DateTime.now(),
//                               userType: 'Student',
//                               email: user.email!,
//                               username: nameController.text,
//                               phoneNumber: phoneNumberController.text,
//                               aboutUser: aboutController.text,
//                               jobTitle: jobController.text,
//                               skills: skillsController.text,
//                               userLocation: locationController.text,
//                               education: educationController.text,
//                               workExperience: jobController.text,
//                               language: languageController.text,
//                               linkedIn: linkedinController.text,
//                               github: githubController.text,
//                               photoUrl: selectedImage?.path ?? '',
//                             );

//                             userCubit.createStudent(users);
//                             final state = userCubit.state;
//                             if (state.isSuccess) {
//                               if (selectedImage != null) {
//                                 final storageReference =
//                                     FirebaseStorage.instance.ref().child(
//                                         'user_photos/${user.uid}/${DateTime.now().toString()}');
//                                 final uploadTask =
//                                     storageReference.putFile(selectedImage!);
//                                 await uploadTask.whenComplete(() async {
//                                   final downloadURL =
//                                       await storageReference.getDownloadURL();
//                                   await FirebaseFirestore.instance
//                                       .collection('users')
//                                       .doc(user.uid)
//                                       .update({'photoUrl': downloadURL});
//                                 });
//                               }
//                             }
//                             Navigator.pushNamed(
//                                 context, AppRouter.studentMainView);
//                           } else {
//                             print('No signed-in user');
//                           }
//                         },
//                         text: 'Катталуу',
//                       ),
//                       if (state.errorMessage.isNotEmpty)
//                         Text(
//                           'Error: ${state.errorMessage}',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
