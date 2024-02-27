import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class EditCompanyProfilePage extends StatelessWidget {
  const EditCompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
        if (state is ProfileSuccessState) {
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
            child: Text('Error fetching user data: ${state.message}'),
          );
        } else  {
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
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                context.read<ProfileCubit>().uploadImage();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: (state is ProfileImageUploadingState)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (uploadedImageUrl != null)
                        ? Image.network(
                            uploadedImageUrl!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.add_a_photo),
              ),
            ),
          ),
          TextFieldWidget(
            controller: nameOfCompanyController,
            label: 'Компаниянын аты',
            validator: 'Сураныч, Компаниянын аталышын  жазыңыз',
            description: 'Компаниянын аты',
            obscureText: false,
            hintText: state.userData?['username'] ?? '',
          ),
          TextFieldWidget(
            controller: aboutCompanyController,
            label: 'Компания тууралуу',
            validator: 'Сураныч, Компания жөнүндө жазыңыз',
            description: 'Компания тууралуу',
            obscureText: false,
            hintText: state.userData?['aboutCompany'] ?? '',
          ),
          TextFieldWidget(
            controller: locationOfCompanyController,
            label: 'Компаниянын жайгашкан жери',
            validator: 'Сураныч, Компаниянын жайгашкан жерин жазыңыз',
            description: 'Компаниянын жайгашкан жери',
            obscureText: false,
            hintText: state.userData?['location'] ?? '',
          ),
          TextFieldWidget(
            controller: contactNumberController,
            label: 'Компаниянын байланыш номери',
            validator: 'Сураныч, Компаниянын байланыш номерин жазыңыз',
            description: 'Компаниянын байланыш номери',
            obscureText: false,
            hintText: state.userData?['phoneNumber'] ?? '',
          ),
          TextFieldWidget(
            controller: webLinkController,
            label: 'Компаниянын web-site',
            validator: 'Сураныч, Компаниянын web-site жазыныз',
            description: 'Компаниянын web-site',
            obscureText: false,
            hintText: state.userData?['webLinkCompany'] ?? '',
          ),
          TextFieldWidget(
            controller: linkedinController,
            label: 'Linkedin',
            validator: 'Сураныч, Компаниянын  Linkedin жазыныз',
            description: 'Linkedin',
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
