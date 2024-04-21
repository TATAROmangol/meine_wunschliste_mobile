import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationViev extends StatelessWidget {
  const NavigationViev({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: const Color(0x80FFFFFF),
      ),
      child: TextButton(
        onPressed: (){},
        child: Text(name),
      )
    );
  }
}
