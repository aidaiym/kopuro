import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final locationController = TextEditingController();

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
                      TextFieldWidget(
                        controller: dateOfBirthController,
                        label: 'Аты-жөнү',
                        validator: 'Сураныч, Аты-жөнү жазыныз',
                        description: 'Аты-жөнү',
                      ),
                      TextFieldWidget(
                        controller: educationController,
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
                        controller: githubController,
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
                        controller: githubController,
                        label: 'иш тажрыйба',
                        validator: 'Сураныч, иш тажрыйба жазыныз',
                        description: 'иш тажрыйба',
                      ),
                      TextFieldWidget(
                        controller: linkedinController,
                        label: 'көндүмдөр',
                        validator: 'Сураныч, көндүмдөр жазыныз',
                        description: 'көндүмдөр',
                      ),
                      TextFieldWidget(
                        controller: linkedinController,
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
                        controller: linkedinController,
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
                              language: jobController.text,
                              linkedIn: linkedinController.text,
                              github: githubController.text,
                              photoUrl: '',
                            );

                            userCubit.createStudent(users);
                            Navigator.pushNamed(
                                context, AppRouter.studentMainView);
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
