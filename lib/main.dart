// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/colortypist/license/.

import 'package:flutter/material.dart';

import 'common/settings.dart' as settings;
import 'common/strings.dart' as strings;
import 'common/theme.dart' as theme;
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
/// Shows the Typist screen by default, and allows navigation to the other screens.
class ColortypistApp extends StatelessWidget {
  const ColortypistApp({super.key});

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

      // The home screen of the app
      home: const TypistScreen(),
    );
  }
}
