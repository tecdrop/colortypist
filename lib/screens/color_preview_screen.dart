// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../models/color_result.dart';
import '../widgets/app_transparency_grid.dart';
import '../widgets/warning.dart';

/// The Color Preview screen.
///
/// Shows a full-screen preview of the given color result, without any UI elements except a Back
/// icon button in the top left corner.
class ColorPreviewScreen extends StatelessWidget {
  const ColorPreviewScreen({
    super.key,
    required this.colorResult,
  });

  /// The color result to preview.
  final ColorResult colorResult;

  @override
  Widget build(BuildContext context) {
    // Display the color result (an opaque color, a partially transparent color, or no valid color)
    // using a combination of [AppTransparencyGrid] and the [Scaffold]'s [backgroundColor].
    return AppTransparencyGrid(
      child: Scaffold(
        backgroundColor: colorResult.color ?? Colors.transparent,

        // A basic app bar that blends in with the rest of the screen, with just a Back icon button
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: colorResult.contrastColor,
          elevation: 0.0,
        ),

        // We should never get here with a null color, but in case we do, show a warning message.
        body: colorResult.color == null
            ? Warning(text: strings.noValidColor, foregroundColor: colorResult.contrastColor)
            : null,
      ),
    );
  }
}
