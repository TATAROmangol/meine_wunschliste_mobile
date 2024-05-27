import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemsView extends StatefulWidget {
  @override
  _ThemsViewState createState() => _ThemsViewState();
}

class _ThemsViewState extends State<ThemsView> {
  Color currentColor = Colors.blue; // Изначальный выбранный цвет

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите цвет'),
      ),
      body: Center(
        child: ColorPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
          showLabel: true, // Показывать метку текущего цвета
          pickerAreaHeightPercent: 0.8, // Процент высоты для области выбора цвета
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Преобразование цвета в int
          int selectedColorInt = currentColor.value;
          print('Выбранный цвет (int): $selectedColorInt');
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

