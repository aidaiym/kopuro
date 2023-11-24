import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules.dart';

class StudentMainView extends StatefulWidget {
  const StudentMainView({super.key});

  @override
  State<StudentMainView> createState() => _StudentMainViewState();
}

class _StudentMainViewState extends State<StudentMainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child:  const MainScreen([
        VacanciesList(),
        StudentProfileView(),

      ]),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen(this.items, {super.key});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[context.watch<MainCubit>().state],
      bottomNavigationBar: NavigationBar(

        onDestinationSelected: context.read<MainCubit>().change,
        selectedIndex: context.watch<MainCubit>().state,
        destinations: const <Widget>[
          NavigationDestination(
            icon:  Icon(Icons.house),
            label: 'Vacancies',
          ),
          NavigationDestination(
            icon:  Icon(Icons.man),
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}