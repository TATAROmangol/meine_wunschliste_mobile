import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/tasks_folders_list/folder_list/folder_list_viev.dart';
import 'package:meine_wunschliste/features/tasks_folders_list/tasks_list/task_list.viev.dart';

class TaskFoldersListViev extends StatelessWidget {
  TaskFoldersListViev({Key? key});

  @override
  Widget build(BuildContext context) { final Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFEEA434),
              title: const Text('Meine Wunschliste'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
            ),
            body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/phon.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(children: <Widget>[
                  FolderListViev(),
                  TaskListViev(),
                  Container(
                      height: screenSize.height * 0.08,
                      padding: const EdgeInsets.only(right: 30.0),
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.add),
                        mini:true,// Цвет кнопки
                        shape: CircleBorder(), // Делаем кнопку круглой
                      ))
                ]))));
  }
}