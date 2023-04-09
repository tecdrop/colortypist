// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// The light and dark themes of the app, and various style utility functions.

import 'package:flutter/material.dart';

/// Defines the default visual properties for this app's material widgets.
///
/// Supports both the light and dark versions of the user interface.
ThemeData appTheme(Brightness brightness) {
  // A color that is white in the light theme and black in the dark theme
  final Color lightWhiteDarkBlack = brightness == Brightness.light ? Colors.white : Colors.black;

  // A color that is black in the light theme and white in the dark theme
  final Color lightBlackDarkWhite = brightness == Brightness.light ? Colors.black : Colors.white;

  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightWhiteDarkBlack,
      brightness: brightness,
      primary: lightWhiteDarkBlack,
      onPrimary: lightBlackDarkWhite,

      // So far used for the app bar of the screens that have a color background (dark theme only)
      // (The AppBar uses the overall theme's ColorScheme.primary if Brightness.light, and
      // ColorScheme.surface if Brightness.dark)
      surface: lightWhiteDarkBlack,
      onSurface: lightBlackDarkWhite,

      // So far used for the background of screens that don't have a color background (the Color
      // Reference or the Settings screen)
      background: lightWhiteDarkBlack,
      onBackground: lightBlackDarkWhite,

      // So far used for floating action buttons and for the active color of the radio tiles in the Settings screen
      secondary: lightBlackDarkWhite,
      onSecondary: lightWhiteDarkBlack,

      // So far used for the app bar of the screens that don't have a color background (e.g. the
      // settings screen)
      primaryContainer:
          brightness == Brightness.light ? const Color(0xFFF5F5F5) : const Color(0xFF0A0A0A),
      onPrimaryContainer: lightBlackDarkWhite,

      // So far used for the default color when no valid color was typed, and for the
      // transparency grid
      // tertiary: const Color(0xFFDCDCDC),
      tertiary: brightness == Brightness.light ? const Color(0xFFEAEAEA) : const Color(0xFF151515),
      onTertiary: lightBlackDarkWhite,
    ),
  ).copyWith(
    // To move into the [TypistTextField] widget in order to customize the text selection colors
    // when https://github.com/flutter/flutter/issues/74890 and
    // https://github.com/flutter/flutter/issues/99231 will be fixed
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.grey,
    ),
  );
}

/// Returns a text style suitable for content subtitles, with the specified text color.
TextStyle subtitleStyle(BuildContext context, {Color? textColor}) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor);
}

/// Returns a text style suitable for list tile titles, with the specified text color.
TextStyle listTileTitleStyle(BuildContext context, {Color? textColor}) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
        color: textColor,
        fontWeight: FontWeight.w500,
      );
}

/// Returns a text style suitable for list tile subtitles, with the specified text color.
TextStyle listTileSubtitleStyle(BuildContext context, {Color? textColor}) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(color: textColor);
}
