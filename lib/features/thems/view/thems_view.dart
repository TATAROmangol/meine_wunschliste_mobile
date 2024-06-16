import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/domain/theme_parameters.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/thems/widgets/change_color.dart';

class ThemsWidgetsView extends StatelessWidget {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final List<(ThemeParameters, int)> selectedColors = [];
  final Repository repository = GetIt.I.get<Repository>();

  void addColor((ThemeParameters, int) info) {
    selectedColors.add(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка темы'),
        backgroundColor: const Color(0xFFFF9648),
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ChangeColor(
              parameterName: "Акцент блоков",
              themeParameters: ThemeParameters.blocsColor,
              startColor: theme.blocsColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Акцент блоков управления",
              themeParameters: ThemeParameters.accentColor,
              startColor: theme.accentColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Цвет текста",
              themeParameters: ThemeParameters.accentColor,
              startColor: theme.accentColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Цвет обводок и границ",
              themeParameters: ThemeParameters.accentColor,
              startColor: theme.accentColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Цвет обводоки выполненных задач",
              themeParameters: ThemeParameters.accentColor,
              startColor: theme.accentColor,
              onColorSelected: addColor,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      await repository.setTheme();
                      Phoenix.rebirth(context);
                    },
                    child: Text("Стандартная тема")),
                TextButton(
                    onPressed: () async {
                      await repository.changeTheme(selectedColors);
                      Phoenix.rebirth(context);
                    },
                    child: Text("Применить")),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

