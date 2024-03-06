import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class EditCompanyProfilePage extends StatelessWidget {
  const EditCompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).editCompanyProfile,
          style: AppTextStyles.black16,
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()
          ..fetchUserData(FirebaseAuth.instance.currentUser!.uid),
        child: const EditCompanyProfileView(),
      ),
    );
  }
}

class EditCompanyProfileView extends StatefulWidget {
  const EditCompanyProfileView({super.key});

  @override
  State<EditCompanyProfileView> createState() => _EditCompanyProfileViewState();
}

class _EditCompanyProfileViewState extends State<EditCompanyProfileView> {
  late TextEditingController nameOfCompanyController;
  late TextEditingController aboutCompanyController;
  late TextEditingController locationOfCompanyController;
  late TextEditingController contactNumberController;
  late TextEditingController webLinkController;
  late TextEditingController linkedinController;
  String? uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    nameOfCompanyController = TextEditingController();
    aboutCompanyController = TextEditingController();
    locationOfCompanyController = TextEditingController();
    contactNumberController = TextEditingController();
    webLinkController = TextEditingController();
    linkedinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState ||
            state is ProfileImageUploadedState ||
            state is ProfileImageUploadingState) {
          uploadedImageUrl = (state is ProfileImageUploadedState)
              ? state.uploadedImageUrl
              : null;
          nameOfCompanyController.text = state.userData?['username'] ?? '';
          aboutCompanyController.text = state.userData?['aboutCompany'] ?? '';
          locationOfCompanyController.text = state.userData?['location'] ?? '';
          contactNumberController.text = state.userData?['phoneNumber'] ?? '';
          webLinkController.text = state.userData?['webLinkCompany'] ?? '';
          linkedinController.text = state.userData?['linkedIn'] ?? '';

          return _buildContent(context, state);
        } else if (state is ProfileErrorState) {
          return Center(
            child: Text(
                '${AppLocalizations.of(context).errorFetchingUserData}: ${state.message}'),
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
            controller: nameOfCompanyController,
            label: AppLocalizations.of(context).companyName,
            validator: AppLocalizations.of(context).nameErrorText,
            description: AppLocalizations.of(context).companyName,
            obscureText: false,
            hintText: state.userData?['username'] ?? '',
          ),
          TextFieldWidget(
            controller: contactNumberController,
            label: AppLocalizations.of(context).phoneNumber,
            validator: AppLocalizations.of(context).numberErrorText,
            description: AppLocalizations.of(context).phoneNumber,
            obscureText: false,
            hintText: state.userData?['phoneNumber'] ?? '',
          ),
          TextFieldWidget(
            controller: aboutCompanyController,
            label: AppLocalizations.of(context).aboutCompany,
            description: AppLocalizations.of(context).aboutCompany,
            obscureText: false,
            hintText: state.userData?['aboutCompany'] ?? '',
          ),
          TextFieldWidget(
            controller: locationOfCompanyController,
            label: AppLocalizations.of(context).location,
            description: AppLocalizations.of(context).location,
            obscureText: false,
            hintText: state.userData?['location'] ?? '',
          ),
          TextFieldWidget(
            controller: webLinkController,
            label: AppLocalizations.of(context).webLinkCompany,
            description: AppLocalizations.of(context).webLinkCompany,
            obscureText: false,
            hintText: state.userData?['webLinkCompany'] ?? '',
          ),
          TextFieldWidget(
            controller: linkedinController,
            label: AppLocalizations.of(context).linkedin,
            description: AppLocalizations.of(context).linkedin,
            obscureText: false,
            hintText: state.userData?['linkedIn'] ?? '',
          ),
          const SizedBox(height: 16),
          MainButton(
            onPressed: () {
              String authenticatedUserId =
                  FirebaseAuth.instance.currentUser?.uid ?? '';

              Map<String, dynamic> updatedData = {
                'photoUrl': uploadedImageUrl,
                'username': nameOfCompanyController.text,
                'aboutCompany': aboutCompanyController.text,
                'location': locationOfCompanyController.text,
                'phoneNumber': contactNumberController.text,
                'webLinkCompany': webLinkController.text,
                'linkedIn': linkedinController.text,
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
