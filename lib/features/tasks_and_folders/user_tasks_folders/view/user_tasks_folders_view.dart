import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/widgets.dart';

class UserTasksFolders extends StatelessWidget {
  const UserTasksFolders({super.key});

  @override
  Widget build(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(
            create: (context) => BlocProvider.of<FoldersBloc>(context)),
        BlocProvider<TasksTreesBloc>(
            create: (context) => BlocProvider.of<TasksTreesBloc>(context))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Мои мечты', style: TextStyle(color: theme.textColor)),
          backgroundColor: theme.accentColor,
          toolbarHeight: screenHeight * 0.05,
        ),
        body: Stack(
          children: [
            const Column(
              children: <Widget>[
                FolderBar(),
                TaskTreeView(),
              ],
            ),
            Positioned(
              right: screenWidth * 0.03,
              top: screenHeight * 0.65,
              child: const TasksTreesButtons(),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
