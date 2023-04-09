// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A simple widget that displays a warning message in the center of the parent widget.
class Warning extends StatelessWidget {
  const Warning({
    super.key,
    this.foregroundColor,
    required this.text,
  });

  /// The warning message to display.
  final String text;

  /// The text color of the warning message.
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: foregroundColor),
      ),
    );
  }
}
