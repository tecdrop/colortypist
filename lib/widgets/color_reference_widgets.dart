// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;
import '../common/theme.dart' as theme;
import '../utils/color_utils.dart' as color_utils;
import 'app_transparency_grid.dart';

/// A color reference list with examples of color formats and color names.
class ColorReferenceList extends StatelessWidget {
  const ColorReferenceList({
    super.key,
    required this.namedColorList,
    required this.namedColorListTitle,
    this.onItemTap,
  });

  /// The callback to invoke when a list item is tapped.
  final void Function(String itemText)? onItemTap;

  /// The list of sample color formats to display.
  static const List<(Color, String)> _colorFormats = [
    (Color(0xFFF97A80), '#F97A80'),
    (Color(0x7FF97A80), '#F97A807F'),
    (Color(0xFFFCEF01), 'rgb(252, 239, 1)'),
    (Color(0x66FCEF01), 'rgba(252, 239, 1, 0.4)'),
    (Color(0xFF6626FF), 'rgb(40%, 15%, 100%)'),
    (Color(0xFF00FF7F), 'hsl(150, 100%, 50%)'),
  ];

  /// The list of named colors to display.
  final Map<String, Color> namedColorList;

  /// The title of the named color list.
  final String namedColorListTitle;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Use a fixed list item height for easier saving and restoring of scroll position.
      itemExtent: 96.0,

      padding: const EdgeInsets.symmetric(vertical: 8.0),

      // We are using a single ListView to display both the color formats and the named colors
      itemCount: _colorFormats.length + 1 + namedColorList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < _colorFormats.length) {
          // Display a color format example.
          return _ColorReferenceItem(
            color: _colorFormats[index].$1,
            text: _colorFormats[index].$2,
            showColorCode: false,
            onTap: onItemTap,
          );
        } else if (index == _colorFormats.length) {
          // Display the named color list title.
          return Center(
            child: ListTile(
              title: Text(namedColorListTitle, style: theme.subtitleStyle(context)),
              subtitle: Text('${namedColorList.length} ${strings.colors}'),
            ),
          );
        } else {
          // Display a named color with the color swatch, name, and hex code.
          return _ColorReferenceItem(
            color: namedColorList.values.elementAt(index - _colorFormats.length - 1),
            text: namedColorList.keys.elementAt(index - _colorFormats.length - 1),
            onTap: onItemTap,
          );
        }
      },
    );
  }
}

/// A color reference item that displays a color swatch, a text and an optional color code.
class _ColorReferenceItem extends StatelessWidget {
  const _ColorReferenceItem({
    // ignore: unused_element
    super.key,
    required this.color,
    required this.text,
    this.showColorCode = true,
    this.onTap,
  });

  /// The color to display as a swatch.
  final Color color;

  /// The text to display to the right of the color swatch.
  final String text;

  /// Whether to show the hex color code below the text.
  final bool showColorCode;

  /// The callback to invoke when the item is tapped.
  final void Function(String text)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(text) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Display the color swatch.
            Expanded(
              flex: 5,
              child: color.alpha != 255
                  ? AppTransparencyGrid(child: Container(color: color))
                  : Container(color: color),
            ),
            const SizedBox(width: 16.0),

            // Display the text and the optional color code.
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: theme.listTileTitleStyle(context)),
                  if (showColorCode) const SizedBox(height: 4.0),
                  if (showColorCode)
                    Text(color_utils.toHexString(color),
                        style: theme.listTileSubtitleStyle(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
