// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

// cspell:ignore autofocus

import 'package:flutter/material.dart';

/// The color typist text field.
class TypistTextField extends StatelessWidget {
  const TypistTextField({
    super.key,
    required this.foregroundColor,
    this.controller,
  });

  /// The foreground color of the text field.
  ///
  /// This is used for the text color, the border color, and the cursor color.
  final Color foregroundColor;

  /// The text field controller, used to get and set the text from the text field.
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    // A simple underline border.
    final InputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(color: foregroundColor, width: 2.0),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: controller,
        autofocus: true,

        // Prevent auto-correct when typing colors.
        // Bug: https://github.com/flutter/flutter/issues/22828
        keyboardType: TextInputType.visiblePassword,

        // Text style, color and decoration.
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: foregroundColor),
        textAlign: TextAlign.center,
        cursorColor: foregroundColor,
        decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}
