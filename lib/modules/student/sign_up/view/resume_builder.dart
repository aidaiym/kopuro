import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../constants/contants.dart';
import '../../../modules.dart';

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({super.key});

  @override
  Widget build(BuildContext context) {

    final nameController = TextEditingController();
    final dateOfBirthController = TextEditingController();
    final educationController = TextEditingController();
    final skillsController = TextEditingController();
    final linkedinController = TextEditingController();
    final githubController = TextEditingController();
    final aboutController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
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
                        controller: skillsController,
                        label: 'Телефон номери',
                        validator: 'Сураныч, Телефон номери жазыныз',
                        description: 'Телефон номери',
                      ),
                      TextFieldWidget(
                        controller: aboutController,
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
                        controller: nameController,
                        label: 'Жумуштун аталышы',
                        validator: 'Сураныч, жумуштун жазыныз',
                        description: 'Жумуштун аталышы',
                      ),
                      Text(
                        'Профессионалдык Кыскача маалымат',
                        style: AppTextStyles.header2,
                      ),
                      TextFieldWidget(
                        controller: linkedinController,
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
                          onPressed: () {
                         
                          },
                          text: 'Катталуу'),
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
