// Copyright 2020-2022 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// A converter that turns any text into a color.

import 'dart:convert';
import 'dart:ui';

import '../models/color_result.dart';
import '../models/enums.dart';
import '../utils/crc24.dart';
import 'color_parser.dart';

/// Converts any text to a color.
///
/// The color is generated from the text using the CRC24 algorithm.
ColorResult convertTextToColor({
  required String text,
  required Color primaryColor,
  required NamedColorType namedColorType,
}) {
  // If the text is empty, return an empty color result.
  if (text.isEmpty) {
    return ColorResult(primaryColor: primaryColor);
  }

  // Encode the text to UTF-8 in order to calculate the CRC24 checksum.
  final List<int> encodedText = utf8.encode(text);

  // Calculate the CRC24 checksum of the text.
  final CRC24 crc24 = CRC24();
  for (int element in encodedText) {
    crc24.update(element);
  }

  // Get a [Color] value from the CRC24 checksum.
  final Color color = Color(crc24.getValue()).withAlpha(255);

  // The color might be a named color. Check and return a color result.
  return colorResultFromColor(
    color: color,
    primaryColor: primaryColor,
    namedColorType: namedColorType,
  );
}
