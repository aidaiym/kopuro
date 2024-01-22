import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: EditProfileView(),
      ),
    );
  }
}

class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController githubController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String? userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          context.read<ProfileCubit>().fetchUserData(userId);
          return _buildContent(context, state);
        }
        if (state is HomeSuccessState) {
          return _buildContent(context, state);
        } else if (state is HomeErrorState) {
          return Center(
            child: Text('Error fetching user data: ${state.message}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProfileState state,
  ) {
    // nameController.text = state.userData?['username'] ?? '';
    phoneNumberController.text = state.userData?['phoneNumber'] ?? '';
    locationController.text = state.userData?['location'] ?? '';
    aboutController.text = state.userData?['aboutMe'] ?? '';
    jobController.text = state.userData?['jobTitle'] ?? '';
    educationController.text = state.userData?['education'] ?? '';
    skillsController.text = state.userData?['skills'] ?? '';
    languageController.text = state.userData?['language'] ?? '';
    linkedinController.text = state.userData?['linkedin'] ?? '';
    githubController.text = state.userData?['github'] ?? '';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFieldWidget(
            controller: nameController,
            label: 'Аты-жөнү',
            validator: 'Сураныч, Аты-жөнү жазыныз',
            description: 'Аты-жөнү',
            obscureText: false,
          ),
          TextFieldWidget(
            controller: phoneNumberController,
            label: 'Телефон номери',
            validator: 'Сураныч, Телефон номери жазыныз',
            description: 'Телефон номери',
            obscureText: false,
          ),
          TextFieldWidget(
            controller: locationController,
            label: 'Жайгашкан жери',
            validator: 'Сураныч, Жайгашкан жери жазыныз',
            description: 'Жайгашкан жери',
            obscureText: false,
          ),
          TextFieldWidget(
            controller: aboutController,
            label: 'мен тууралуу',
            validator: 'Сураныч, мен тууралуу жазыныз',
            description: 'мен тууралуу',
            obscureText: false,
          ),
          TextFieldWidget(
            obscureText: false,
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
            obscureText: false,
            controller: educationController,
            label: 'билим',
            validator: 'Сураныч, билим жазыныз',
            description: 'билим',
          ),
          TextFieldWidget(
            obscureText: false,
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
            obscureText: false,
          ),
          TextFieldWidget(
            controller: linkedinController,
            label: 'Linkedin',
            validator: 'Сураныч, Linkedin жазыныз',
            description: 'Linkedin',
            obscureText: false,
          ),
          TextFieldWidget(
            controller: githubController,
            label: 'Github',
            validator: 'Сураныч, Github жазыныз',
            description: 'Github',
            obscureText: false,
          ),
          const SizedBox(height: 16),
          MainButton(
            onPressed: () {
              String authenticatedUserId =
                  FirebaseAuth.instance.currentUser?.uid ?? '';
              Map<String, dynamic> updatedData = {
                'username': nameController.text,
                'phoneNumber': phoneNumberController.text,
                'location': locationController.text,
                'aboutMe': aboutController.text,
                'jobTitle': jobController.text,
                'education': educationController.text,
                'skills': skillsController.text,
                'language': languageController.text,
                'linkedin': linkedinController.text,
                'github': githubController.text,
              };

              context
                  .read<ProfileCubit>()
                  .updateUserData(authenticatedUserId, updatedData);
              Navigator.pop(context);
            },
            text: 'Өзгөрүүлөрдү сактоо',
          ),
        ],
      ),
    );
  }
}
