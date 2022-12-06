// Copyright 2020-2022 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

// cspell:ignore prefs

/// The app settings, loaded from and saved to persistent storage.

import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums.dart';

// -----------------------------------------------------------------------------------------------
// Typist text related setting
// -----------------------------------------------------------------------------------------------

/// A convenience function for getting the text that was last typed by the user in the given
/// [typistType] mode.
String getTypistText(TypistType typistType) {
  switch (typistType) {
    case TypistType.typeColor:
      return typeColorText;
    case TypistType.textToColor:
      return textToColorText;
  }
}

/// A convenience function for saving the text that was last typed by the user in the given
/// [typistType] mode.
void setTypistText(TypistType typistType, String text) {
  switch (typistType) {
    case TypistType.typeColor:
      typeColorText = text;
      break;
    case TypistType.textToColor:
      textToColorText = text;
      break;
  }
}

// -----------------------------------------------------------------------------------------------
// typeColorText setting
// -----------------------------------------------------------------------------------------------

const String _typeColorTextKey = 'typeColorText';
const String _typeColorTextDefault = 'fuchsia';

String _typeColorText = _typeColorTextDefault;

/// The app setting that saves and restores the text that was last typed by the user in the
/// Type Color mode.
String get typeColorText => _typeColorText;
set typeColorText(String value) {
  _typeColorText = value;
  _saveTypeColorText();
}

/// Saves the [typeColorText] setting to persistent storage.
Future<void> _saveTypeColorText() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(_typeColorTextKey, _typeColorText);
}

// -----------------------------------------------------------------------------------------------
// textToColorText setting
// -----------------------------------------------------------------------------------------------

const String _textToColorTextKey = 'textToColorText';
const String _textToColorTextDefault = 'Colortypist';

String _textToColorText = _textToColorTextDefault;

/// The app setting that saves and restores the text that was last typed by the user in the
/// Text to Color mode.
String get textToColorText => _textToColorText;
set textToColorText(String value) {
  _textToColorText = value;
  _saveTextToColorText();
}

/// Saves the [textToColorText] setting to persistent storage.
Future<void> _saveTextToColorText() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(_textToColorTextKey, _textToColorText);
}

// -----------------------------------------------------------------------------------------------
// namedColorType setting
// -----------------------------------------------------------------------------------------------

const String _namedColorTypeKey = 'namedColorType';
const NamedColorType _namedColorTypeDefault = NamedColorType.standard;

NamedColorType _namedColorType = _namedColorTypeDefault;

/// The app setting that saves and restores the current named color type (basic, standard, or
/// extended).
NamedColorType get namedColorType => _namedColorType;
set namedColorType(NamedColorType value) {
  _namedColorType = value;
  _saveNamedColorType();
}

/// Saves the [namedColorType] setting to persistent storage.
Future<void> _saveNamedColorType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_namedColorTypeKey, _namedColorType.index);
}

// -----------------------------------------------------------------------------------------------
// Common
// -----------------------------------------------------------------------------------------------

/// Loads app settings from persistent storage.
Future<void> load() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _typeColorText = prefs.getString(_typeColorTextKey) ?? _typeColorTextDefault;
  _textToColorText = prefs.getString(_textToColorTextKey) ?? _textToColorTextDefault;
  _namedColorType =
      NamedColorType.values[prefs.getInt(_namedColorTypeKey) ?? _namedColorTypeDefault.index];
}
