import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/profile/widgets/progress_bars/progress_bars_widget.dart';
import 'package:meine_wunschliste/features/profile/widgets/widgets.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final listenBloc = BlocProvider.of<TasksTreesBloc>(context);
    final UserTheme theme = GetIt.I.get<UserTheme>();
    return BlocProvider(
      create: (context) => TasksTreesBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Мой профиль', style: TextStyle(color: theme.textColor)),
          backgroundColor: theme.accentColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        ),
        body: Column(
          children: [
            ProfileWidget(),
            ProgressBarsWidget(listenBloc: listenBloc),
            LogOutWidget(),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
