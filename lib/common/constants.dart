// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/colortypist/license/.

/// Application wide constants: urls, etc.
library;

// -----------------------------------------------------------------------------------------------
// App urls
// -----------------------------------------------------------------------------------------------

/// The url of the app that can be used to set a color wallpaper.
const String setWallpaperUrl =
    'https://www.tecdrop.com/rgbcolorwallpaperpro/?utm_source=colortypist&utm_medium=app&utm_campaign=colortypist_drawer';
const String setWallpaperUrlAndroid =
    'https://play.google.com/store/apps/details?id=com.tecdrop.rgbcolorwallpaperpro&referrer=utm_source%3Dcolortypist%26utm_medium%3Dapp%26utm_campaign%3Dcolortypist_drawer';

/// The url of the app's Google Play Store page, where the user can rate the app.
const String rateUrl =
    'https://play.google.com/store/apps/details?id=com.tecdrop.colortypist&referrer=utm_source%3Dcolortypist%26utm_medium%3Dapp%26utm_campaign%3Dcolortypist_drawer';

/// The url of the app's home page where the user can find more information about the app.
const String helpUrl =
    'https://www.tecdrop.com/colortypist/?utm_source=colortypist&utm_medium=app&utm_campaign=colortypist_drawer';

/// The url of the app's source code repository.
const String viewSourceUrl = 'https://github.com/tecdrop/colortypist';

/// The url that is used to search color information on the web.
const String onlineSearchUrl = 'https://www.google.com/search?q=';

// -----------------------------------------------------------------------------------------------
// Other constants
// -----------------------------------------------------------------------------------------------

/// The color swatch image file name for a given hex code.
String colorSwatchFileName(String hexCode) => 'colortypist_${hexCode}_color_swatch.png';
