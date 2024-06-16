import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/domain/theme_parameters.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/thems/widgets/change_color.dart';

class ThemsWidgetsView extends StatelessWidget {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final Set<(ThemeParameters, String)> selectedColors = {};
  final Repository repository = GetIt.I.get<Repository>();

  void addColor((ThemeParameters, String) info) {
    selectedColors.removeWhere((element) => element.$1 == info.$1);
    selectedColors.add(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройка темы', style: TextStyle(color: theme.textColor)),
        backgroundColor: theme.accentColor,
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
              themeParameters: ThemeParameters.textColor,
              startColor: theme.textColor,
              onColorSelected: addColor,
            ),
            ChangeColor(
              parameterName: "Цвет обводок и границ",
              themeParameters: ThemeParameters.borderColor,
              startColor: theme.borderColor,
              onColorSelected: addColor,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await repository.setTheme();
                    Phoenix.rebirth(context);
                  },
                  child: Text("Стандартная тема"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await repository.changeTheme(selectedColors.toList());
                    Phoenix.rebirth(context);
                  },
                  child: Text("Применить"),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
