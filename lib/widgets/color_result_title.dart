// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../models/color_result.dart';
import '../utils/color_utils.dart' as color_utils;

/// A simple widget that displays a color result as a title.
///
/// If the color result is a valid color, displays the color name if available, or the hex color
/// code. The color result title is tappable and can display a tooltip.
///
/// If the color result is not a valid color, displays a specified hint text.
class ColorResultTitle extends StatelessWidget {
  const ColorResultTitle({
    super.key,
    required this.colorResult,
    required this.noColorHint,
    this.tooltip,
    this.onResultTap,
  });

  /// The color result to display.
  final ColorResult colorResult;

  /// The title to display when there is no color.
  final String noColorHint;

  /// The text to display in the tooltip.
  final String? tooltip;

  /// Called when the user taps on the title when it displays a valid color.
  final GestureTapCallback? onResultTap;

  @override
  Widget build(BuildContext context) {
    if (colorResult.color != null) {
      final String title = colorResult.name ?? color_utils.toHexString(colorResult.color!);
      return InkWell(
        onTap: onResultTap,
        child: Tooltip(
          message: tooltip,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(strings.yourColorIs, style: Theme.of(context).textTheme.bodySmall),
                Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
              ],
            ),
          ),
        ),
      );
    }

    // If the color is not valid, display the hint text as a title.
    return Text(noColorHint);
  }
}
