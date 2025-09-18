// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/colortypist/license/.

/// Color utilities.
library;

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'utils.dart' as utils;

/// Returns the black or white contrast color of a given color.
Color contrastBWColorOf(Color color) {
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

int _alpha(Color color) => (color.a * 255.0).round() & 0xff;

/// Returns the alpha channel of a color as a two-digit hexadecimal string, or an empty string if
/// the alpha channel should not be shown.
String _getAlpha(Color color, ShowAlpha showAlpha) {
  return showAlpha == ShowAlpha.always ||
          (showAlpha == ShowAlpha.ifNotOpaque && _alpha(color) != 255)
      ? _alpha(color).toRadixString(16).padLeft(2, '0')
      : '';
}

String _opacitySuffix(Color color, ShowAlpha showAlpha) {
  return showAlpha == ShowAlpha.always ||
          (showAlpha == ShowAlpha.ifNotOpaque && _alpha(color) != 255)
      ? ', ${color.a.toStringAsFixed(2)}'
      : '';
}

/// Converts a [Color] value into a hexadecimal color string.
String toHexString(
  Color color, {
  bool withHash = true,
  ShowAlpha showAlpha = ShowAlpha.ifNotOpaque,
}) {
  final String alpha = _getAlpha(color, showAlpha);
  final String rgb = (color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0');
  return '${withHash ? '#' : ''}$rgb$alpha'.toUpperCase();
}

/// Returns the RGB string representation of the given [Color].
String toRGBString(Color color) {
  final String opacity = _opacitySuffix(color, ShowAlpha.ifNotOpaque);
  return '${(color.r * 255).round()}, ${(color.g * 255).round()}, ${(color.b * 255).round()}$opacity';
}

/// Returns the HSL string representation of the given [Color].
String toHSLString(Color color) {
  HSLColor hslColor = HSLColor.fromColor(color);
  final String opacity = _opacitySuffix(color, ShowAlpha.ifNotOpaque);
  return '${hslColor.hue.toStringAsFixed(0)}, ${(hslColor.saturation * 100).toStringAsFixed(0)}%, ${(hslColor.lightness * 100).toStringAsFixed(0)}%$opacity';
}

/// Returns the HSV string representation of the given [Color].
String toHSVString(Color color) {
  HSVColor hsvColor = HSVColor.fromColor(color);
  final String opacity = _opacitySuffix(color, ShowAlpha.ifNotOpaque);
  return '${hsvColor.hue.toStringAsFixed(0)}, ${(hsvColor.saturation * 100).toStringAsFixed(0)}%, ${(hsvColor.value * 100).toStringAsFixed(0)}%$opacity';
}

/// Returns the decimal string representation of the given [Color] value.
String toDecimalString(Color color) {
  return utils.intToCommaSeparatedString(color.withAlpha(0).toARGB32());
}

/// Returns the string representation of the opacity (alpha channel) of the given [Color].
String opacityString(Color color) {
  return color.a.toStringAsFixed(2);
}

/// Returns the string representation of the relative luminance of the given [Color].
String luminanceString(Color color) {
  return color.computeLuminance().toStringAsFixed(5);
}

/// Returns the string representation (`light` or `dark`) of the brightness of the given [Color].
String brightnessString(Color color) {
  return ThemeData.estimateBrightnessForColor(color).name;
}

/// Builds a color swatch image of the given [color] with the specified [width] and [height].
Future<Uint8List> buildColorSwatch(Color color, int width, int height) async {
  // Create the color swatch using a sequence of graphical operations
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()));
  canvas.drawColor(color, BlendMode.src);
  final ui.Picture picture = recorder.endRecording();

  // Convert the picture to a PNG image and return its bytes
  final ui.Image img = await picture.toImage(width, height);
  final ByteData? pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
  return pngBytes!.buffer.asUint8List();
}
