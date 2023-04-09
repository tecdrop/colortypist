// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../utils/color_utils.dart' as color_utils;

/// Holds the result of a color parsing operation.
class ColorResult {
  /// Creates a new instance of [ColorResult].
  ///
  /// The [primaryColor] is used to determine the contrast color in case [color] is null or not
  /// fully opaque.
  ColorResult({
    this.color,
    required Color primaryColor,
    this.name,
  }) : contrastColor = color_utils.contrastOf(
          Color.alphaBlend(color ?? primaryColor, primaryColor),
        );

  /// The color value. Can be null if the color parsing operation has failed.
  final Color? color;

  /// The black or white color that has the best contrast with [color].
  final Color contrastColor;

  /// The color name. Can be null if the color parsing operation has failed, or the color is not a
  /// named color.
  final String? name;

  String get title {
    if (color != null) {
      final String colorCode = color_utils.toHexString(color!);
      return name != null ? '$name $colorCode' : colorCode;
    }

    return strings.noValidColor;
  }

  @override
  String toString() {
    return 'ColorResult{color: $color, contrastColor: $contrastColor, name: $name}';
  }
}
