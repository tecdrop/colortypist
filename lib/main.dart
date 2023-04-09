// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'common/constants.dart' as constants;
import 'common/settings.dart' as settings;
import 'common/strings.dart' as strings;
import 'common/theme.dart' as theme;
import 'models/color_result.dart';
import 'screens/color_info_screen.dart';
import 'screens/color_preview_screen.dart';
import 'screens/color_reference_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/typist_screen.dart';

Future<void> main() async {
  // First try to load the app settings from Shared Preferences
  WidgetsFlutterBinding.ensureInitialized();
  await Future.any([
    settings.load(),
    Future.delayed(const Duration(seconds: 5)),
  ]);

  // Run the app
  runApp(const ColortypistApp());
}

/// The root widget of the Colortypist app.
///
/// Shows the Typist screen in Type Color mode as the initial route.
class ColortypistApp extends StatelessWidget {
  const ColortypistApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: strings.appName,

      // The light theme of the app, based on white to go along with all the various colors that can
      // be typed by the user
      theme: theme.appTheme(Brightness.light),

      // The dark theme of the app, based on black to go along with all the various colors that can
      // be typed by the user
      darkTheme: theme.appTheme(Brightness.dark),

      // The home route of the app
      initialRoute: constants.typeColorRoute,

      // Define the routes of the app
      routes: <String, Widget Function(BuildContext)>{
        // The Typist route in Type Color mode
        constants.typeColorRoute: (BuildContext context) => const TypistScreen(),

        // The Color Reference route
        constants.colorReferenceRoute: (BuildContext context) => const ColorReferenceScreen(),

        // The Settings route
        constants.settingsRoute: (BuildContext context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // The Color Information route, with the color result passed as an argument
          case constants.colorInfoRoute:
            return MaterialPageRoute(
              builder: (_) => ColorInfoScreen(colorResult: settings.arguments as ColorResult),
            );

          // The Color Preview route, with the color result passed as an argument
          case constants.previewColorRoute:
            return MaterialPageRoute(
              builder: (_) => ColorPreviewScreen(colorResult: settings.arguments as ColorResult),
            );
        }

        // Let onUnknownRoute handle this behavior.
        return null;
      },
    );
  }
}
