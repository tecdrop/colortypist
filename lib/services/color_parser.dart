// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// A color parser from named colors and CSS color strings.

import 'package:flutter/material.dart';

import 'package:from_css_color/from_css_color.dart';

import '../data/basic_colors.dart' as basic_colors;
import '../data/extended_colors.dart' as extended_colors;
import '../data/standard_colors.dart' as standard_colors;
import '../models/color_result.dart';
import '../models/enums.dart';

/// Converts a [Color] value to a [ColorResult], by searching for a matching color name of the
/// given [NamedColorType].
ColorResult colorResultFromColor({
  required Color color,
  required Color primaryColor,
  required NamedColorType namedColorType,
}) {
  // We need the fully opaque color so we can search for it in the maps of color names.
  final Color opaqueColor = color.withAlpha(255);

  switch (namedColorType) {
    case NamedColorType.basic:
      String? colorName = basic_colors.getColorName(opaqueColor);
      if (colorName != null) {
        return ColorResult(color: color, name: colorName, primaryColor: primaryColor);
      }
      break;
    case NamedColorType.standard:
      String? colorName = standard_colors.getColorName(opaqueColor);
      if (colorName != null) {
        return ColorResult(color: color, name: colorName, primaryColor: primaryColor);
      }
      break;
    case NamedColorType.extended:
      String? colorName = extended_colors.getColorName(opaqueColor);
      if (colorName != null) {
        return ColorResult(color: color, name: colorName, primaryColor: primaryColor);
      }
      break;
  }

  return ColorResult(color: color, primaryColor: primaryColor);
}

/// Parses a user input string and tries to convert it to a valid [Color] value, with a potential
/// color name of the given [NamedColorType].
ColorResult parseColor({
  required String source,
  required Color primaryColor,
  required NamedColorType namedColorType,
}) {
  // Remove leading and trailing whitespace and convert to lowercase.
  source = source.trim().toLowerCase();

  // Try to parse a color name
  switch (namedColorType) {
    case NamedColorType.basic:
      // Try to parse a named color from the basic set
      Color? color = basic_colors.parseColor(source);
      if (color != null) {
        return ColorResult(color: color, primaryColor: primaryColor, name: source);
      }
      break;
    case NamedColorType.standard:
      // Try to parse a named color from the standard set (Web Color Names)
      Color? color = standard_colors.parseColor(source);
      if (color != null) {
        return ColorResult(color: color, primaryColor: primaryColor, name: source);
      }
      break;
    case NamedColorType.extended:
      // Try to parse a named color from the extended set (xkcd color survey)
      Color? color = extended_colors.parseColor(source);
      if (color != null) {
        return ColorResult(color: color, primaryColor: primaryColor, name: source);
      }
      break;
  }

  // For the time being, the from_css_color package has built-in support for CSS color names (our
  // standard color names). So if the current named color type is basic or extended, we should
  // prevent the from_css_color package from wrongly parsing standard color names.
  if (namedColorType != NamedColorType.standard && standard_colors.parseColor(source) != null) {
    return ColorResult(primaryColor: primaryColor);
  }

  // Try to parse a CSS color string using the from_css_color package
  if (isCssColor(source)) {
    Color color = fromCssColor(source);
    return colorResultFromColor(
      color: color,
      primaryColor: primaryColor,
      namedColorType: namedColorType,
    );
  }

  return ColorResult(primaryColor: primaryColor);
}
