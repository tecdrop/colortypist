// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'transparency_grid.dart';

/// A convenience widget that allows to easily create a [TransparencyGrid] with appropriate values
/// for this app.
///
/// Transparency grids are frequently used in this app so this widget is used to reduce boilerplate
/// code. The checkerboard colors are based on the current theme's primary and tertiary colors.
class AppTransparencyGrid extends StatelessWidget {
  const AppTransparencyGrid({
    super.key,
    this.child,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TransparencyGrid(
      light: Theme.of(context).colorScheme.primary,
      dark: Theme.of(context).colorScheme.tertiary,
      squareSize: 8.0,
      child: child,
    );
  }
}
