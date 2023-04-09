// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/settings.dart' as settings;
import '../common/strings.dart' as strings;
import '../data/basic_colors.dart' as basic_colors;
import '../data/extended_colors.dart' as extended_colors;
import '../data/standard_colors.dart' as standard_colors;
import '../models/enums.dart';
import '../widgets/color_reference_widgets.dart';

/// The storage bucket used to store the scroll position of the Color Reference list view.
final PageStorageBucket colorReferenceBucket = PageStorageBucket();

/// The Color Reference screen.
///
/// This screen displays a list of color formats and names that the user can type to get a color.
/// The colors are not selectable and are only displayed as a reference. The user should learn these
/// color formats and names, and use them to type colors in the [Type Color] screen.
class ColorReferenceScreen extends StatelessWidget {
  const ColorReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a [PageStorage] widget to store / restore the scroll position of the [ColorReferenceList]
    // while the app is running.
    return PageStorage(
      bucket: colorReferenceBucket,
      child: Scaffold(
        // A simple app bar with just a standard title and subtitle.
        appBar: const _AppBar(),

        // The color reference list with examples of color formats, and the current named color set
        body: ColorReferenceList(
          key: PageStorageKey(settings.namedColorType.name),
          namedColorList: settings.namedColorType == NamedColorType.basic
              ? basic_colors.colorMap
              : settings.namedColorType == NamedColorType.standard
                  ? standard_colors.colorMap
                  : extended_colors.colorMap,
          namedColorListTitle: strings.namedColorTypeTitle[settings.namedColorType]!,
          onItemTap: (text) {
            settings.typeColorText = text;
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

/// A simple app bar with just a title and subtitle.
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  // ignore: unused_element
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.colorReferenceScreenTitle,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          Text(
            strings.colorReferenceScreenSubtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
