import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

class ProgressSubSubtaskWidget extends StatelessWidget {
  ProgressSubSubtaskWidget({super.key});

  final Repository repository = GetIt.I.get<Repository>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<(int, int)>(
      future: repository.getProgressTasks(Steps.subSubtask),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFFE0C3).withOpacity(1),
            ),
            height: screenSize.height * 0.12,
            width: screenSize.width * 0.90,
            margin: EdgeInsets.only(
              left: screenSize.width * 0.05,
              right: screenSize.width * 0.05,
            ),
            child: Row(
              children: [
                const Text("Выполнено подзадач: "),
                Text('${tasks.$2}/${tasks.$1}'),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
