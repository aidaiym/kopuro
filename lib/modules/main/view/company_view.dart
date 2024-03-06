import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/l10n/l10.dart';
import 'package:kopuro/modules/modules.dart';

class CompanyMainView extends StatefulWidget {
  const CompanyMainView({super.key});
    static Page<void> page() =>
      const MaterialPage<void>(child: CompanyMainView());

  @override
  State<CompanyMainView> createState() => _CompanyMainViewState();
}

class _CompanyMainViewState extends State<CompanyMainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: const CompanyMainScreen(
        [
          CandidatesListView(),
          CompanyVacanciesView(),
        ],
      ),
    );
  }
}

class CompanyMainScreen extends StatelessWidget {
  const CompanyMainScreen(this.items, {super.key});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[context.watch<MainCubit>().state],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: context.read<MainCubit>().change,
        selectedIndex: context.watch<MainCubit>().state,
        destinations:  <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.people),
            label: AppLocalizations.of(context).candidates,
          ),
          NavigationDestination(
            icon: const Icon(Icons.work_outline),
            label:  AppLocalizations.of(context).addVacancy,
          ),
        ],
      ),
    );
  }
}
