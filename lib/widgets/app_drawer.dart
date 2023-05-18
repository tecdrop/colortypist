// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

// cspell:ignore fullscreen

import 'package:flutter/material.dart';

import '../common/custom_icons.dart' as custom_icons;
import '../common/strings.dart' as strings;
import '../models/color_result.dart';
import 'app_transparency_grid.dart';

/// The items that are displayed in the app drawer.
enum AppDrawerItems {
  typeColor,
  colorReference,
  previewColor,
  colorInfo,
  setWallpaper,
  settings,
  help,
  rateApp,
  viewSource,
}

/// The main Material Design app drawer of the app, with the main app actions.
class AppDrawer extends StatelessWidget {
  /// Creates a new instance of the app drawer.
  const AppDrawer({
    Key? key,
    required this.colorResult,
    this.onItemTap,
  }) : super(key: key);

  /// The current color result to display in the app drawer header.
  ///
  /// Also used for navigation to some screens that require a color result.
  final ColorResult colorResult;

  /// The callback that is executed when an item in the app drawer is tapped.
  final void Function(AppDrawerItems item)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // The header of the drawer with the color preview and the app name
          _AppDrawerHeader(
            colorResult: colorResult,
            title: strings.appName,
          ),

          // The Set Color Wallpaper drawer item
          ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            tileColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.075),
            leading: const Icon(Icons.wallpaper),
            title: const Text(strings.setWallpaperDrawerTitle),
            subtitle: const Text(strings.setWallpaperDrawerSubtitle),
            isThreeLine: true,
            onTap: () => onItemTap?.call(AppDrawerItems.setWallpaper),
          ),

          // The Type Color drawer item
          _buildItem(
            context,
            icon: Icons.colorize,
            title: strings.typeColorDrawerTitle,
            subtitle: strings.typeColorDrawerSubtitle,
            item: AppDrawerItems.typeColor,
          ),

          // The Color Reference drawer item
          _buildItem(
            context,
            icon: Icons.help_outline,
            title: strings.colorReferenceDrawer,
            item: AppDrawerItems.colorReference,
          ),

          const Divider(),

          // The Preview Color drawer item
          _buildItem(
            context,
            icon: Icons.fullscreen,
            title: strings.previewColorDrawer,
            item: AppDrawerItems.previewColor,
            enabled: colorResult.color != null,
          ),

          // The Color Information drawer item
          _buildItem(
            context,
            icon: Icons.info_outline,
            title: strings.colorInfoDrawer,
            item: AppDrawerItems.colorInfo,
            enabled: colorResult.color != null,
          ),

          // The Settings drawer item
          _buildItem(
            context,
            icon: Icons.settings_outlined,
            title: strings.settingsDrawer,
            item: AppDrawerItems.settings,
          ),

          const Divider(),

          // The Online Help drawer item
          _buildItem(
            context,
            icon: Icons.support_outlined,
            title: strings.helpDrawer,
            item: AppDrawerItems.help,
          ),

          // The Rate App drawer item (currently shown only on Android)
          if (Theme.of(context).platform == TargetPlatform.android)
            _buildItem(
              context,
              icon: Icons.star_rate_outlined,
              title: strings.rateAppDrawer,
              item: AppDrawerItems.rateApp,
            ),

          // The Star on GitHub drawer item
          _buildItem(
            context,
            icon: custom_icons.github,
            title: strings.starOnGitHubTitle,
            subtitle: strings.starOnGitHubSubtitle,
            item: AppDrawerItems.viewSource,
          ),
        ],
      ),
    );
  }

  /// Builds a drawer item with the given icon, title, subtitle and item.
  Widget _buildItem(
    BuildContext context, {
    IconData? icon,
    required String title,
    String? subtitle,
    required AppDrawerItems item,
    bool? enabled,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      enabled: enabled ?? true,
      onTap: () => onItemTap?.call(item),
    );
  }
}

/// The header of the app drawer.
class _AppDrawerHeader extends StatelessWidget {
  const _AppDrawerHeader({
    Key? key,
    required this.colorResult,
    required this.title,
  }) : super(key: key);

  /// The current color result to display as the background of the drawer header.
  final ColorResult colorResult;

  /// The title of the drawer header.
  final String title;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,

      // The background of the drawer header should be exactly the same as the background of the
      // typist screen, including the transparency grid for invalid or partially transparent colors
      child: AppTransparencyGrid(
        child: Container(
          color: colorResult.color ?? Colors.transparent,
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: colorResult.contrastColor,
                ),
          ),
        ),
      ),
    );
  }
}
