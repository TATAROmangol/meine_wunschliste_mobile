import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/custom_bottom_navigation_bar.dart';
import 'package:meine_wunschliste/features/profile/view/profile_view.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/complete_tasks/view/complete_tasks_view.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/view/view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UserTasksFolders(),
    const CompleteTasksView(),
    const ProfileView(),
  ];

  void _onTabTappedInit(int index, TasksTreesBloc initBloc) {
    setState(() {
      _currentIndex = index;
      initBloc.add(ShowTasksTreesEvent());
    });
  }

  void _onTabTappedReload(int index, TasksTreesBloc reloadedBloc) {
    setState(() {
      _currentIndex = index;
      reloadedBloc.add(ReloadStatisticRootEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(
          create: (context) => FoldersBloc(),
        ),
        BlocProvider<TasksTreesBloc>(
          create: (context) => TasksTreesBloc(),
        ),
      ],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _screens,
                ),
              ),
              CustomBottomNavigationBar(
                currentIndex: _currentIndex,
                onInit: _onTabTappedInit,
                onReload: _onTabTappedReload,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
