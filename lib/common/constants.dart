// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// Application wide constants: routes, urls, etc.

// -----------------------------------------------------------------------------------------------
// App routes
// -----------------------------------------------------------------------------------------------

/// This is the default route of the app. It opens the "Type Colors" typist screen.
const String typeColorRoute = '/';

/// The name of the route for the Preview Color screen.
const String previewColorRoute = '/preview-color';

/// The name of the route for the Color Information screen.
const String colorInfoRoute = '/color-info';

/// The name of the route for the Color Reference screen.
const String colorReferenceRoute = '/color-reference';

/// The name of the route for the Settings screen.
const String settingsRoute = '/settings';

// -----------------------------------------------------------------------------------------------
// App urls
// -----------------------------------------------------------------------------------------------

/// The url of the app that can be used to set a color wallpaper.
const String setWallpaperUrl =
    'https://play.google.com/store/apps/details?id=com.tecdrop.rgbcolorwallpaperpro&referrer=utm_source%3Dcolortypist%26utm_medium%3Dapp%26utm_campaign%3Dcolortypist_aa_drawer';

/// The url of the app's Google Play Store page, where the user can rate the app.
const String rateUrl =
    'https://play.google.com/store/apps/details?id=com.tecdrop.colortypist&referrer=utm_source%3Dcolortypist%26utm_medium%3Dapp%26utm_campaign%3Dcolortypist_aa_drawer';

/// The url of the app's home page where the user can find more information about the app.
const String helpUrl =
    'https://www.tecdrop.com/colortypist/?utm_source=colortypist&utm_medium=app&utm_campaign=colortypist_aa_drawer';

/// The url of the app's source code repository.
const String viewSourceUrl = 'https://github.com/tecdrop/colortypist';

/// The url that is used to search color information on the web.
const String onlineSearchUrl = 'https://www.google.com/search?q=';
