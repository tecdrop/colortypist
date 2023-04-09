// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// The basic colors map and functions to parse and return basic color names.

import 'dart:ui';

/// Parses [source] as a basic color name and returns the [Color] value, or null if the [source]
/// string does not contain a valid color name.
@override
Color? parseColor(String source) {
  return colorMap[source];
}

/// Returns the name of the given [color] from the basic color map, or null if the [color] is not
/// a basic color.
@override
String? getColorName(Color color) {
  return _reversedColorMap[color];
}

/// Provides a map of [Color] constants corresponding to basic color names.
///
/// Imported from the [the 12 RGB C O L O R S](https://www.1728.org/RGB.htm).
const Map<String, Color> colorMap = {
  'red': Color(0XFFFF0000),
  'rose': Color(0XFFFF0080),
  'bright pink': Color(0XFFFF0080),
  'magenta': Color(0XFFFF00FF),
  'fuchsia': Color(0XFFFF00FF),
  'violet': Color(0XFF8800FF),
  'blue': Color(0XFF0000FF),
  'azure': Color(0XFF0088FF),
  'cyan': Color(0XFF00FFFF),
  'aqua': Color(0XFF00FFFF),
  'spring green': Color(0XFF00FF88),
  'green': Color(0XFF00FF00),
  'lime': Color(0XFF00FF00),
  'chartreuse': Color(0XFF88FF00),
  'yellow': Color(0XFFFFFF00),
  'orange': Color(0XFFFF8800),
  'black': Color(0XFF000000),
  'white': Color(0XFFFFFFFF),
};

/// The reverse map used to get color names from [Color]s.
final Map<Color, String> _reversedColorMap = colorMap.map((k, v) => MapEntry(v, k));
