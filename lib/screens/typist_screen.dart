// Copyright 2020-2022 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../utils/utils.dart' as utils;
import '../common/constants.dart' as constants;
import '../common/settings.dart' as settings;
import '../common/strings.dart' as strings;
import '../models/color_result.dart';
import '../models/enums.dart';
import '../services/color_parser.dart';
import '../services/text_to_color_converter.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_transparency_grid.dart';
import '../widgets/color_result_title.dart';
import '../widgets/typist_text_field.dart';

/// The Typist screen.
///
/// This is the main screen of the app. It allows the user to type in a color name or code to be
/// parsed, or a text to be converted to a color.
class TypistScreen extends StatefulWidget {
  const TypistScreen({
    super.key,
    required this.typistType,
  });

  /// The typist type (Type Color or Text To Color).
  final TypistType typistType;

  @override
  State<TypistScreen> createState() => _TypistScreenState();
}

class _TypistScreenState extends State<TypistScreen> {
  late ColorResult _colorResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Make sure the color result is updated on app startup and when the theme changes
    _colorResult = _parseText(settings.getTypistText(widget.typistType));
  }

  /// Parses the text and updates the color result when the user inserts or deletes text in the
  /// typist text field.
  void _onTypistTextFieldChanged(String text) {
    settings.setTypistText(widget.typistType, text);
    _colorResult = _parseText(text);
    setState(() {});
  }

  /// Parses the given text and returns the color result, based on the current typist type.
  ColorResult _parseText(String text) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    switch (widget.typistType) {
      case TypistType.typeColor:
        return parseColor(
          source: text,
          primaryColor: primaryColor,
          namedColorType: settings.namedColorType,
        );
      case TypistType.textToColor:
        return convertTextToColor(
          text: text,
          primaryColor: primaryColor,
          namedColorType: settings.namedColorType,
        );
    }
  }

  /// Executes the action of the selected drawer item.
  Future<void> _onDrawerItemTap(AppDrawerItems item) async {
    switch (item) {

      // Navigate to the Type Color screen by replacing the current screen
      case AppDrawerItems.typeColor:
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, constants.typeColorRoute);
        break;

      // Navigate to the Color Reference screen
      case AppDrawerItems.colorReference:
        Navigator.pop(context);
        Navigator.pushNamed(context, constants.colorReferenceRoute);
        break;

      // Navigate to the Text To Color screen by replacing the current screen
      case AppDrawerItems.textToColor:
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, constants.textToColorRoute);
        break;

      // Navigate to the Preview Color screen
      case AppDrawerItems.previewColor:
        Navigator.pop(context);
        Navigator.pushNamed(context, constants.previewColorRoute, arguments: _colorResult);
        break;

      // Navigate to the Color Information screen
      case AppDrawerItems.colorInfo:
        Navigator.pop(context);
        Navigator.pushNamed(context, constants.colorInfoRoute, arguments: _colorResult);
        break;

      // Launch the external Set Wallpaper url
      case AppDrawerItems.setWallpaper:
        Navigator.pop(context);
        utils.launchUrlExternal(context, constants.setWallpaperUrl);
        break;

      // Navigate to the Settings screen
      case AppDrawerItems.settings:
        Navigator.pop(context);
        await Navigator.pushNamed(context, constants.settingsRoute);

        // Reparse the text after returning from the Settings screen as the user may have changed
        // the color name set
        _colorResult = _parseText(settings.getTypistText(widget.typistType));
        setState(() {});
        break;

      // Launch the external Help url
      case AppDrawerItems.help:
        Navigator.pop(context);
        utils.launchUrlExternal(context, constants.helpUrl);
        break;

      // Launch the external Rate App url
      case AppDrawerItems.rateApp:
        Navigator.pop(context);
        utils.launchUrlExternal(context, constants.rateUrl);
        break;

      // Launch the external View Source url
      case AppDrawerItems.viewSource:
        Navigator.pop(context);
        utils.launchUrlExternal(context, constants.viewSourceUrl);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // The combination of [AppTransparencyGrid] and the [Scaffold]'s [backgroundColor] is used to
    // display the color result, which can be:
    // * a solid color
    // * a partially transparent color that gets painted over the transparency grid background
    // * just the transparency grid background if the user has not typed a valid color yet
    return AppTransparencyGrid(
      child: Scaffold(
        backgroundColor: _colorResult.color ?? Colors.transparent,

        // The app bar which displays the color result (a hex code, a color name and a hex code, or
        // a typing hint), and allows the user to perform common actions.
        appBar: _AppBar(
          typistType: widget.typistType,
          colorResult: _colorResult,
        ),

        // The app drawer which allows the user to navigate to other screens.
        drawer: AppDrawer(colorResult: _colorResult, onItemTap: _onDrawerItemTap),

        // The body which contains the typist text field in the center, where the user can enter a
        // color, or a text to get converted to a color.
        body: Center(
          child: TypistTextField(
            typistType: widget.typistType,
            foregroundColor: _colorResult.contrastColor,
            onChanged: _onTypistTextFieldChanged,
            initialValue: settings.getTypistText(widget.typistType),
          ),
        ),
      ),
    );
  }
}

/// The available actions that can be performed from the app bar.
enum _AppBarActions {
  colorInfo,
  colorReference,
}

/// The app bar of the Typist screen.
///
/// Displays the color result in the title, and allows the user to perform common actions.
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.typistType,
    required this.colorResult,
  }) : super(key: key);

  /// The typist type (Type Color or Text To Color).
  final TypistType typistType;

  /// The color result to display in the app bar title.
  final ColorResult colorResult;

  /// Perform the actions of the app bar.
  Future<void> _onAction(BuildContext context, _AppBarActions action) async {
    switch (action) {
      case _AppBarActions.colorInfo:
        await Navigator.pushNamed(context, constants.colorInfoRoute, arguments: colorResult);
        break;
      case _AppBarActions.colorReference:
        await Navigator.pushNamed(context, constants.colorReferenceRoute);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Display the color result in the title
      title: ColorResultTitle(
        colorResult: colorResult,
        noColorHint: strings.noColorHint[typistType]!,
      ),
      actions: <Widget>[
        // The color info action which navigates to the Color Information screen. This action is
        // only enabled if the user has entered a valid color.
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: strings.infoActionTooltip,
          onPressed:
              colorResult.color != null ? () => _onAction(context, _AppBarActions.colorInfo) : null,
        ),

        // The color reference action is only available in the Type Color screen
        if (typistType == TypistType.typeColor)
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: strings.referenceActionTooltip,
            onPressed: () => _onAction(context, _AppBarActions.colorReference),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
