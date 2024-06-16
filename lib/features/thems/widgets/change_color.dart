import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meine_wunschliste/domain/theme_parameters.dart';

class ChangeColor extends StatefulWidget {
  ChangeColor({
    required this.parameterName,
    required this.themeParameters,
    required this.startColor,
    required this.onColorSelected,
  });

  final String parameterName;
  final ThemeParameters themeParameters;
  final Color startColor;
  final ValueChanged<(ThemeParameters, int)> onColorSelected;

  @override
  _ChangeColorState createState() =>
      _ChangeColorState(currentColor: startColor, startColor: startColor);
}

class _ChangeColorState extends State<ChangeColor> {
  _ChangeColorState({required this.currentColor, required this.startColor});

  Color startColor;
  Color currentColor;

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите цвет'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  currentColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Отмена'),
              onPressed: () {
                setState(() {
                  currentColor = startColor;
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Готово'),
              onPressed: () {
                widget.onColorSelected(
                    (widget.themeParameters, currentColor.value));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _showColorPicker(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: currentColor,
          border: const Border(
            left: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            right: BorderSide(
              color: Colors.black,
              width: 3.0,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: 3.0,
            ),
            top: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        height: screenSize.height * 0.09,
        width: screenSize.width * 0.91,
        child: Center(child: Text(widget.parameterName)),
      ),
    );
  }
}
