import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()
          ..fetchUserData(FirebaseAuth.instance.currentUser!.uid),
        child: const EditProfileView(),
      ),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController locationController;
  late TextEditingController aboutController;
  late TextEditingController jobController;
  late TextEditingController educationController;
  late TextEditingController skillsController;
  late TextEditingController languageController;
  late TextEditingController linkedinController;
  late TextEditingController githubController;
  late TextEditingController workExperience;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    locationController = TextEditingController();
    aboutController = TextEditingController();
    jobController = TextEditingController();
    educationController = TextEditingController();
    workExperience = TextEditingController();
    skillsController = TextEditingController();
    languageController = TextEditingController();
    linkedinController = TextEditingController();
    githubController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          nameController.text = state.userData?['username'] ?? '';
          phoneNumberController.text = state.userData?['phoneNumber'] ?? '';
          locationController.text = state.userData?['location'] ?? '';
          aboutController.text = state.userData?['aboutUser'] ?? '';
          jobController.text = state.userData?['jobTitle'] ?? '';
          educationController.text = state.userData?['education'] ?? '';
          workExperience.text = state.userData?['workExperience'] ?? '';
          skillsController.text = state.userData?['skills'] ?? '';
          languageController.text = state.userData?['language'] ?? '';
          linkedinController.text = state.userData?['linkedIn'] ?? '';
          githubController.text = state.userData?['github'] ?? '';
          return _buildContent(context, state);
        } else if (state is ProfileErrorState) {
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

  Widget _buildContent(BuildContext context, ProfileState state) {
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
            hintText: state.userData?['username'] ?? '',
          ),
          TextFieldWidget(
            controller: phoneNumberController,
            label: 'Телефон номери',
            validator: 'Сураныч, Телефон номери жазыныз',
            description: 'Телефон номери',
            obscureText: false,
            hintText: state.userData?['phoneNumber'] ?? '',
          ),
          TextFieldWidget(
            controller: locationController,
            label: 'Жайгашкан жери',
            validator: 'Сураныч, Жайгашкан жери жазыныз',
            description: 'Жайгашкан жери',
            obscureText: false,
            hintText: state.userData?['location'] ?? '',
          ),
          TextFieldWidget(
            controller: aboutController,
            label: 'мен тууралуу',
            validator: 'Сураныч, мен тууралуу жазыныз',
            description: 'мен тууралуу',
            obscureText: false,
            hintText: state.userData?['aboutUser'] ?? '',
          ),
          TextFieldWidget(
            hintText: state.userData?['jobTitle'] ?? '',
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
            hintText: state.userData?['education'] ?? '',
          ),
          TextFieldWidget(
            obscureText: false,
            controller: workExperience,
            label: 'workExperience',
            validator: 'Сураныч, workExperience жазыныз',
            description: 'workExperience',
            hintText: state.userData?['workExperience'] ?? '',
          ),
          TextFieldWidget(
            obscureText: false,
            controller: skillsController,
            label: 'көндүмдөр',
            validator: 'Сураныч, көндүмдөр жазыныз',
            description: 'көндүмдөр',
            hintText: state.userData?['skills'] ?? '',
          ),
          TextFieldWidget(
            controller: languageController,
            label: 'тил',
            validator: 'Сураныч, тил жазыныз',
            description: 'тил',
            obscureText: false,
            hintText: state.userData?['language'] ?? '',
          ),
          TextFieldWidget(
            controller: linkedinController,
            label: 'Linkedin',
            validator: 'Сураныч, Linkedin жазыныз',
            description: 'Linkedin',
            obscureText: false,
            hintText: state.userData?['linkedIn'] ?? '',
          ),
          TextFieldWidget(
            controller: githubController,
            label: 'Github',
            validator: 'Сураныч, Github жазыныз',
            description: 'Github',
            obscureText: false,
            hintText: state.userData?['github'] ?? '',
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
                'aboutUser': aboutController.text,
                'jobTitle': jobController.text,
                'education': educationController.text,
                'workExperience': workExperience.text,
                'skills': skillsController.text,
                'language': languageController.text,
                'linkedIn': linkedinController.text,
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
