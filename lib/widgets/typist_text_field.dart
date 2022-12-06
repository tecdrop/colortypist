// Copyright 2020-2022 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

// cspell:ignore autofocus

import 'package:flutter/material.dart';

import '../models/enums.dart';

class TypistTextField extends StatefulWidget {
  const TypistTextField({
    Key? key,
    required this.typistType,
    required this.initialValue,
    required this.foregroundColor,
    this.onChanged,
  }) : super(key: key);

  /// The type of the text field (Type Color or Text To Color).
  final TypistType typistType;

  /// The initial value of the text field.
  final String initialValue;

  /// The foreground color of the text field.
  ///
  /// This is used for the text color, the border color, and the cursor color.
  final Color foregroundColor;

  /// Called when the text field's value changes.
  final ValueChanged<String>? onChanged;

  @override
  State<TypistTextField> createState() => _TypistTextFieldState();
}

class _TypistTextFieldState extends State<TypistTextField> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Use the controller to set the initial value.
    _textFieldController.text = widget.initialValue;
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A simple underline border.
    final InputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(color: widget.foregroundColor, width: 2.0),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: _textFieldController,
        autofocus: true,
        minLines: widget.typistType == TypistType.textToColor ? 1 : null,
        maxLines: widget.typistType == TypistType.textToColor ? 10 : null,

        // Prevent auto-correct when typing colors.
        // Bug: https://github.com/flutter/flutter/issues/22828
        keyboardType: widget.typistType == TypistType.typeColor
            ? TextInputType.visiblePassword
            : TextInputType.multiline,

        // Text style, color and decoration.
        style: Theme.of(context).textTheme.headline6!.copyWith(color: widget.foregroundColor),
        textAlign: TextAlign.center,
        cursorColor: widget.foregroundColor,
        decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder: border,
        ),

        onChanged: widget.onChanged,
      ),
    );
  }
}
