// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// User interface string constants.
///
/// These are texts that are displayed to the user and can be localized in future versions.

import 'package:colortypist/models/enums.dart';

// -----------------------------------------------------------------------------------------------
// App
// -----------------------------------------------------------------------------------------------

const String appName = 'Colortypist';

// -----------------------------------------------------------------------------------------------
// Common
// -----------------------------------------------------------------------------------------------

const String noValidColor = 'No valid color!';
const String copied = 'copied to clipboard';
const String copyFail = 'Copy to clipboard failed:';
const String openFail = 'Failed to open';

const String noColorHint = 'Type a color';

const Map<NamedColorType, String> namedColorTypeTitle = {
  NamedColorType.basic: 'Basic color names',
  NamedColorType.standard: 'Standard color names (web)',
  NamedColorType.extended: 'Extended color names (xkcd)',
};

// -----------------------------------------------------------------------------------------------
// Drawer items
// -----------------------------------------------------------------------------------------------

const String setWallpaperDrawerTitle = 'Set A Color Wallpaper';
const String setWallpaperDrawerSubtitle = 'Use RGB Color Wallpaper Pro\nand support our free apps!';
const String typeColorDrawerTitle = 'Type Colors';
const String typeColorDrawerSubtitle = 'Type color names or codes';
const String colorReferenceDrawer = 'Color Reference';
const String previewColorDrawer = 'Preview Color';
const String colorInfoDrawer = 'Color Information';
const String settingsDrawer = 'Settings';
const String rateAppDrawer = 'Rate App';
const String helpDrawer = 'Help & Support';
const String starOnGitHubTitle = 'Star on GitHub';
const String starOnGitHubSubtitle = 'Yes, $appName is open source!';

// -----------------------------------------------------------------------------------------------
// Typist Color Screen(s)
// -----------------------------------------------------------------------------------------------

const String yourColorIs = 'Your color is';

const String infoActionTooltip = 'Color information';
const String referenceActionTooltip = 'Color reference';

// -----------------------------------------------------------------------------------------------
// Color Info Screen
// -----------------------------------------------------------------------------------------------

const String colorInfoScreenTitle = 'Color Information';

const String colorNameInfo = 'Name';
const String colorTitleInfo = 'Name & code';
const String hexInfo = 'Hex triplet';
const String rgbInfo = 'RGB';
const String hslInfo = 'HSL';
const String opacityInfo = 'Opacity';
const String luminanceInfo = 'Luminance';
const String brightnessInfo = 'Brightness';

const String copyTooltip = 'Copy to clipboard';
const String shareTooltip = 'Share';
const String searchTooltip = 'Search on the Internet';

// -----------------------------------------------------------------------------------------------
// Color Reference Screen
// -----------------------------------------------------------------------------------------------

const String colorReferenceScreenTitle = 'Color Reference';
const String colorReferenceScreenSubtitle = 'Formats and names you can use';
const String colors = 'colors';

// -----------------------------------------------------------------------------------------------
// Settings Screen
// -----------------------------------------------------------------------------------------------

const String settingsScreenTitle = 'Settings';
const String typeColorSectionTitle = 'Type Colors';

const Map<NamedColorType, String> namedColorTypeRadioTitle = {
  NamedColorType.basic: 'Use basic color names',
  NamedColorType.standard: 'Use standard color names',
  NamedColorType.extended: 'Use extended color names',
};

const Map<NamedColorType, String> namedColorTypeRadioSubtitle = {
  NamedColorType.basic:
      'Use a basic set of 18 color names of primary, secondary, and tertiary colors',
  NamedColorType.standard:
      'Use the standard set of 148 web colors defined in the CSS Color Module Level 4',
  NamedColorType.extended:
      'Use an extended set of 954 named colors defined in the xkcd color name survey',
};
