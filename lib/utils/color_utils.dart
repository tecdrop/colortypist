// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// Color utilities.

import 'package:flutter/material.dart';

/// Returns the black or white contrast color of a given color.
Color contrastOf(Color color) {
  return ThemeData.estimateBrightnessForColor(color) == Brightness.light
      ? Colors.black
      : Colors.white;
}

/// When to display the alpha channel of a color.
enum ShowAlpha {
  /// Always show the alpha value.
  always,

  /// Never show the alpha value.
  never,

  /// Show the alpha value only if it is not 255.
  ifNotOpaque,
}

bool _showAlpha(Color color, ShowAlpha showAlpha) {
  return showAlpha == ShowAlpha.always ||
      (showAlpha == ShowAlpha.ifNotOpaque && color.alpha != 255);
}

/// Converts a [Color] value into a hexadecimal color string.
String toHexString(Color color, {ShowAlpha showAlpha = ShowAlpha.ifNotOpaque}) {
  final String alpha =
      showAlpha == ShowAlpha.always || (showAlpha == ShowAlpha.ifNotOpaque && color.alpha != 255)
          ? color.alpha.toRadixString(16).padLeft(2, '0')
          : '';
  final String rgb = (color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0');
  return '#$rgb$alpha'.toUpperCase();
}

/// Returns the RGB string representation of a [Color].
String toRGBString(Color color, {ShowAlpha showAlpha = ShowAlpha.ifNotOpaque}) {
  final String opacity =
      _showAlpha(color, showAlpha) ? ', ${color.opacity.toStringAsFixed(2)}' : '';
  return '${color.red}, ${color.green}, ${color.blue}$opacity';
}

/// Returns the HSL string representation of a [Color].
String toHSLString(Color color, {ShowAlpha showAlpha = ShowAlpha.ifNotOpaque}) {
  HSLColor hslColor = HSLColor.fromColor(color);
  final String opacity =
      _showAlpha(color, showAlpha) ? ', ${color.opacity.toStringAsFixed(2)}' : '';
  return '${hslColor.hue.toStringAsFixed(0)}°, ${(hslColor.saturation * 100).toStringAsFixed(0)}%, ${(hslColor.lightness * 100).toStringAsFixed(0)}%$opacity';
}
