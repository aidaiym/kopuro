import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class EditStudentProfilePage extends StatelessWidget {
  const EditStudentProfilePage({super.key});

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
          UploadImageWidget(
            state: state,
            onTap: () {
              context.read<ProfileCubit>().uploadImage();
            },
          ),
          TextFieldWidget(
            controller: nameController,
            label: AppLocalizations.of(context).fullName,
            validator: AppLocalizations.of(context).nameErrorText,
            description: '${AppLocalizations.of(context).fullName} *',
            obscureText: false,
            hintText: state.userData?['username'] ?? '',
          ),
          TextFieldWidget(
            controller: phoneNumberController,
            label: AppLocalizations.of(context).phoneNumber,
            validator: AppLocalizations.of(context).numberErrorText,
            description: '${AppLocalizations.of(context).phoneNumber} *',
            obscureText: false,
            hintText: state.userData?['phoneNumber'] ?? '',
          ),
          TextFieldWidget(
            hintText: state.userData?['jobTitle'] ?? '',
            obscureText: false,
            controller: jobController,
            label: AppLocalizations.of(context).jobTitle,
            validator: AppLocalizations.of(context).jobValidator,
            description: '${AppLocalizations.of(context).jobTitle} *',
          ),
          TextFieldWidget(
            obscureText: false,
            controller: workExperience,
            label: AppLocalizations.of(context).workExperienceLabel,
            validator: AppLocalizations.of(context).workExperienceValidator,
            description:
                '${AppLocalizations.of(context).workExperienceLabel} *',
            hintText: state.userData?['workExperience'] ?? '',
          ),
          TextFieldWidget(
            obscureText: false,
            controller: skillsController,
            label: AppLocalizations.of(context).skillsLabel,
            validator: AppLocalizations.of(context).skillsValidator,
            description: '${AppLocalizations.of(context).skillsLabel} *',
            hintText: state.userData?['skills'] ?? '',
          ),
          TextFieldWidget(
            controller: locationController,
            label: AppLocalizations.of(context).locationLabel,
            description: AppLocalizations.of(context).locationLabel,
            obscureText: false,
            hintText: state.userData?['location'] ?? '',
          ),
          TextFieldWidget(
            controller: aboutController,
            label: AppLocalizations.of(context).aboutLabel,
            description: AppLocalizations.of(context).aboutLabel,
            obscureText: false,
            hintText: state.userData?['aboutUser'] ?? '',
          ),
          TextFieldWidget(
            obscureText: false,
            controller: educationController,
            label: AppLocalizations.of(context).educationLabel,
            description: AppLocalizations.of(context).educationLabel,
            hintText: state.userData?['education'] ?? '',
          ),
          TextFieldWidget(
            controller: languageController,
            label: AppLocalizations.of(context).languageLabel,
            description: AppLocalizations.of(context).languageLabel,
            obscureText: false,
            hintText: state.userData?['language'] ?? '',
          ),
          TextFieldWidget(
            controller: linkedinController,
            label: AppLocalizations.of(context).linkedinLabel,
            description: AppLocalizations.of(context).linkedinLabel,
            obscureText: false,
            hintText: state.userData?['linkedIn'] ?? '',
          ),
          TextFieldWidget(
            controller: githubController,
            label: AppLocalizations.of(context).githubLabel,
            description: AppLocalizations.of(context).githubLabel,
            obscureText: false,
            hintText: state.userData?['github'] ?? '',
          ),
          const SizedBox(height: 16),
          MainButton(
            onPressed: () async {
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
                'photoUrl': 'uploadImageUrl',
              };

              context
                  .read<ProfileCubit>()
                  .updateUserData(authenticatedUserId, updatedData);
              Navigator.pop(context);
            },
            text: AppLocalizations.of(context).saveChanges,
          ),
        ],
      ),
    );
  }
}
