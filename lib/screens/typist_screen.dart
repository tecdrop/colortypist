// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../utils/utils.dart' as utils;
import '../common/constants.dart' as constants;
import '../common/settings.dart' as settings;
import '../common/strings.dart' as strings;
import '../models/color_result.dart';
import '../services/color_parser.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_transparency_grid.dart';
import '../widgets/color_result_title.dart';
import '../widgets/typist_text_field.dart';

/// The Typist screen.
///
/// This is the main screen of the app. It allows the user to type in a color name or code to be
/// parsed, or a text to be converted to a color.
class TypistScreen extends StatefulWidget {
  const TypistScreen({super.key});

  @override
  State<TypistScreen> createState() => _TypistScreenState();
}

class _TypistScreenState extends State<TypistScreen> {
  late ColorResult _colorResult;

  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textFieldController.addListener(() {
      _onTypistTextFieldChanged(_textFieldController.text);
    });

    // Use the controller to set the initial value.
    _textFieldController.text = settings.typeColorText;
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Make sure the color result is updated on app startup and when the theme changes
    _colorResult = _parseText(settings.typeColorText);
  }

  /// Parses the text and updates the color result when the user inserts or deletes text in the
  /// typist text field.
  void _onTypistTextFieldChanged(String text) {
    settings.typeColorText = text;
    _colorResult = _parseText(text);
    setState(() {});
  }

  /// Parses the given text and returns the color result, based on the current typist type.
  ColorResult _parseText(String text) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return parseColor(
      source: text,
      primaryColor: primaryColor,
      namedColorType: settings.namedColorType,
    );
  }

  /// Navigates to the Color Info screen to display information about the current color.
  void _gotoColorInfoScreen() {
    Navigator.pushNamed(context, constants.colorInfoRoute, arguments: _colorResult);
  }

  /// Navigates to the Color Reference screen and updates the text in the typist text field with the
  /// color name selected from the Color Reference screen.
  void _gotoColorReferenceScreen() async {
    await Navigator.pushNamed(context, constants.colorReferenceRoute);
    _textFieldController.text = settings.typeColorText;
  }

  /// Perform the actions of the app bar.
  void _onAppBarAction(_AppBarActions action) {
    switch (action) {
      case _AppBarActions.colorInfo:
        _gotoColorInfoScreen();
        break;
      case _AppBarActions.colorReference:
        _gotoColorReferenceScreen();
        break;
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
        _gotoColorReferenceScreen();
        break;

      // Navigate to the Preview Color screen
      case AppDrawerItems.previewColor:
        Navigator.pop(context);
        Navigator.pushNamed(context, constants.previewColorRoute, arguments: _colorResult);
        break;

      // Navigate to the Color Information screen
      case AppDrawerItems.colorInfo:
        Navigator.pop(context);
        _gotoColorInfoScreen();
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
        _colorResult = _parseText(settings.typeColorText);
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
          colorResult: _colorResult,
          onAppBarAction: _onAppBarAction,
        ),

        // The app drawer which allows the user to navigate to other screens.
        drawer: AppDrawer(colorResult: _colorResult, onItemTap: _onDrawerItemTap),

        // The body which contains the typist text field in the center, where the user can enter a
        // color, or a text to get converted to a color.
        body: Center(
          child: TypistTextField(
            foregroundColor: _colorResult.contrastColor,
            controller: _textFieldController,
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
    required this.colorResult,
    this.onAppBarAction,
  }) : super(key: key);

  /// The color result to display in the app bar title.
  final ColorResult colorResult;

  /// Called when the user taps an app bar icon button or menu item.
  final void Function(_AppBarActions)? onAppBarAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Display the color result in the title
      title: ColorResultTitle(
        colorResult: colorResult,
        noColorHint: strings.noColorHint,
      ),
      actions: <Widget>[
        // The color info action which navigates to the Color Information screen. This action is
        // only enabled if the user has entered a valid color.
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: strings.infoActionTooltip,
          onPressed: colorResult.color != null
              ? () => onAppBarAction?.call(_AppBarActions.colorInfo)
              : null,
        ),

        // The color reference action which navigates to the Color Reference screen.
        IconButton(
          icon: const Icon(Icons.help_outline),
          tooltip: strings.referenceActionTooltip,
          onPressed: () => onAppBarAction?.call(_AppBarActions.colorReference),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
