// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:ui';

import '../data/basic_colors.dart' as basic_colors;
import '../data/extended_colors.dart' as extended_colors;
import '../data/standard_colors.dart' as standard_colors;
import '../models/enums.dart';
import '../utils/color_utils.dart' as color_utils;

Random _random = Random.secure();

Color _getRandomColor() {
  return Color.fromARGB(
    255,
    _random.nextInt(256),
    _random.nextInt(256),
    _random.nextInt(256),
  );
}

String getRandomColorNameOrCode(NamedColorType namedColorType) {
  bool randomName = _random.nextBool();

  if (randomName) {
    Map<String, Color> colorMap = switch (namedColorType) {
      NamedColorType.basic => basic_colors.colorMap,
      NamedColorType.standard => standard_colors.colorMap,
      NamedColorType.extended => extended_colors.colorMap,
    };
    return colorMap.keys.elementAt(_random.nextInt(colorMap.length));
  } else {
    // Return a random color hex code
    return color_utils.toHexString(_getRandomColor());
  }
}
