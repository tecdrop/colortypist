// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

import '../common/constants.dart' as constants;
import '../common/strings.dart' as strings;
import '../common/theme.dart' as theme;
import '../models/color_result.dart';
import '../utils/color_utils.dart' as color_utils;
import '../utils/utils.dart' as utils;
import '../widgets/app_transparency_grid.dart';
import '../widgets/warning.dart';

/// The Color Information screen.
///
/// Displays the given color in different formats, and allows the user to copy, share, or
/// search the Internet for any of the color information.
class ColorInfoScreen extends StatefulWidget {
  const ColorInfoScreen({
    super.key,
    required this.colorResult,
  });

  /// The color name and code that is displayed in the info screen.
  final ColorResult colorResult;

  @override
  State<ColorInfoScreen> createState() => _ColorInfoScreenState();
}

class _ColorInfoScreenState extends State<ColorInfoScreen> {
  /// The color information list.
  late final List<({String name, String value})> _infoList;

  /// The index of the currently selected information item in the list view.
  int _selectedIndex = 0;

  /// Build the color information list on init state.
  @override
  void initState() {
    super.initState();
    _infoList = _buildInfoList(widget.colorResult);
  }

  /// Copies the currently selected color information item to the Clipboard, and shows a
  /// confirmation SnackBar.
  void _onCopyPressed() {
    final String value = _infoList[_selectedIndex].value;
    utils.copyToClipboard(context, value);
  }

  /// Shares the currently selected color information item via the platform's share dialog.
  void _onSharePressed() {
    final String value = _infoList[_selectedIndex].value;
    Share.share(value, subject: strings.appName);
  }

  /// Performs a web search for the currently selected color information item.
  void _onSearchPressed() {
    final String value = _infoList[_selectedIndex].value;
    final String url = constants.onlineSearchUrl + Uri.encodeComponent(value);
    utils.launchUrlExternal(context, url);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = MediaQuery.of(context).size.height >= 500;

    // We should never get here with a null color, but just in case use the primary color
    final Color color = widget.colorResult.color ?? Theme.of(context).colorScheme.primary;
    final Color foregroundColor = widget.colorResult.contrastColor;
    final Color selectedTileColor = Color.alphaBlend(foregroundColor.withOpacity(0.25), color);
    final Color selectedColor = color_utils.contrastOf(selectedTileColor);

    return AppTransparencyGrid(
      child: Scaffold(
        // Fill the color information screen with the current color
        backgroundColor: color,

        // The app bar of this screen
        appBar: _AppBar(
          onSearchPressed: _onSearchPressed,
        ),

        // The body contains a list view with all the color information items
        body: widget.colorResult.color == null
            ? Warning(text: strings.noValidColor, foregroundColor: widget.colorResult.contrastColor)
            : ListView.builder(
                itemCount: _infoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      _infoList[index].value,
                      style: theme.listTileTitleStyle(context, textColor: foregroundColor),
                    ),
                    subtitle: Text(
                      _infoList[index].name,
                      style: theme.listTileSubtitleStyle(context, textColor: foregroundColor),
                    ),
                    textColor: foregroundColor,
                    selected: index == _selectedIndex,
                    selectedColor: selectedColor,
                    selectedTileColor: selectedTileColor,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                },
              ),
        floatingActionButton: widget.colorResult.color != null ? _buildFABs(isPortrait) : null,
      ),
    );
  }

  /// Builds the color information list.
  static List<({String name, String value})> _buildInfoList(ColorResult colorResult) {
    final List<({String name, String value})> infoList = [];

    // We should never have a null color here, but just in case check and return an empty list
    if (colorResult.color == null) {
      return infoList;
    }

    // Simply a convenience function that adds the given name/value info to the list.
    void addInfoItem(String name, String value) => infoList.add((name: name, value: value));

    final Color color = colorResult.color!;
    if (colorResult.name != null) {
      addInfoItem(strings.colorTitleInfo, colorResult.title);
      addInfoItem(strings.colorNameInfo, colorResult.name!);
    }
    addInfoItem(strings.hexInfo, color_utils.toHexString(color));
    addInfoItem(strings.rgbInfo, color_utils.toRGBString(color));
    addInfoItem(strings.hslInfo, color_utils.toHSLString(color));

    if (color.opacity != 1.0) {
      addInfoItem(strings.opacityInfo, color.opacity.toStringAsFixed(3));
    }
    addInfoItem(strings.luminanceInfo, color.computeLuminance().toStringAsFixed(3));
    addInfoItem(strings.brightnessInfo, describeEnum(ThemeData.estimateBrightnessForColor(color)));

    return infoList;
  }

  /// Builds the three main floating action buttons for copying, sharing and searching for the
  /// currently selected color info.
  Widget _buildFABs(bool isPortrait) {
    return Flex(
      direction: isPortrait ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'copyFAB',
          onPressed: _onCopyPressed,
          tooltip: strings.copyTooltip,
          child: const Icon(Icons.copy),
        ),
        isPortrait ? const SizedBox(height: 16.0) : const SizedBox(width: 16.0),
        FloatingActionButton(
          heroTag: 'shareFAB',
          onPressed: _onSharePressed,
          tooltip: strings.shareTooltip,
          child: const Icon(Icons.share),
        ),
      ],
    );
  }
}

/// The app bar of the Color Information screen.
///
/// Displays the screen title and the search button.
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    // ignore: unused_element
    super.key,
    this.onSearchPressed,
  });

  /// Called when the user taps the search action button.
  final void Function()? onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(strings.colorInfoScreenTitle),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search_outlined),
          tooltip: strings.infoActionTooltip,
          onPressed: onSearchPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
