import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class UserTasks extends StatelessWidget {
  UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final foldersBloc = FoldersBloc();
    final tasksBloc = TasksBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(create: (context) => foldersBloc),
        BlocProvider<TasksBloc>(create: (context) => tasksBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9648),
          title: const Text('Meine Wunschliste'),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {},
          ),
<<<<<<< HEAD
          actions: const [AddFolderWidget()],
=======
          actions: [
            GestureDetector(
              child: const Icon(Icons.folder_copy_outlined),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddFolderWidget(
                      foldersBloc: foldersBloc,
                      tasksBloc: tasksBloc,
                    );
                  },
                );
              },
            ),
          ],
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
<<<<<<< HEAD
              const FolderBar(),
              TaskTreeView(),
              const AddRootTask(),
=======
              FolderBar(),
              TaskTreeView(),
              Container(
                height: 50,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddTopTask(
                          tasksBloc: tasksBloc,
                        );
                      },
                    );
                  },
                ),
              )
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
            ],
          ),
        ),
      ),
    );
  }
}
