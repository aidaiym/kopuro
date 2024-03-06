import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class StudentMainView extends StatefulWidget {
  const StudentMainView({super.key});
  static Page<void> page() =>
      const MaterialPage<void>(child: StudentMainView());
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (_) => MainCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(),
        ),
      ],
      child: MainScreen([
        BlocProvider(
            create: (context) => VacancyCubit()..loadVacancies(),
            child: const VacanciesList()),
        const StudentProfileView(),
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
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.house),
            label: AppLocalizations.of(context).vacancies,
          ),
          NavigationDestination(
            icon: const Icon(Icons.man),
            label: AppLocalizations.of(context).profile,
          ),
        ],
      ),
    );
  }
}
