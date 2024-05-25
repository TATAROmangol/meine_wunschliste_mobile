import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int, TasksTreesBloc) onInit;
  final Function(int, TasksTreesBloc) onReload;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onInit,
    required this.onReload,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reloadBloc = BlocProvider.of<TasksTreesBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
    return ClipPath(
      clipper: BottomAppBarClipper(),
      child: Container(
        height: screenSize.height * 0.07,
        color: const Color(0xFFFF9648),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onReload(2, reloadBloc),
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => onInit(1, reloadBloc),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => onInit(0, reloadBloc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 20.0;
    final Path path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
