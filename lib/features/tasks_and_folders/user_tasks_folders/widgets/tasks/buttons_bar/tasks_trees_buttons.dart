import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/folders/folders_buttons/add_folder_button.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons_bar.dart';

class TasksTreesButtons extends StatefulWidget {
  const TasksTreesButtons({super.key});

  @override
  TasksTreesButtonsState createState() => TasksTreesButtonsState();
}

class TasksTreesButtonsState extends State<TasksTreesButtons> {
  final Repository repository = GetIt.I.get<Repository>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final tasksTreesBloc = BlocProvider.of<TasksTreesBloc>(context);

    return BlocBuilder<TasksTreesBloc, TasksTreesState>(
      bloc: tasksTreesBloc,
      builder: (context, state) {
        return (state is ShowTasksTreesState && state.activeChildUid == '')
            ? Column(
                children: [
                  state.children.length > 1
                      ? ChangeTreesOrderButton(tasksTreesBloc: tasksTreesBloc)
                      : Container(
                          height: screenSize.height * 0.045,
                          margin: const EdgeInsets.only(bottom: 5)),
                  repository.activeFolder.folder != null
                      ? const AddTasksTreeButton()
                      : Container(
                          height: screenSize.height * 0.045,
                          margin: const EdgeInsets.only(bottom: 5)),
                  const AddFolderButton(),
                ],
              )
            : Container();
      },
    );
  }
}
