// Copyright 2020-2023 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/settings.dart' as settings;
import '../common/strings.dart' as strings;
import '../common/theme.dart' as theme;
import '../models/enums.dart';

/// The Settings screen.
///
/// Allows the user to change the app's settings.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onStandardSetChanged(NamedColorType? value) {
    if (value != null) {
      setState(() {
        settings.namedColorType = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A simple app bar with just a title and a back button
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: const Text(strings.settingsScreenTitle),
      ),

      // The list of available settings that can be changed by the user
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 16.0),
          ListTile(
            title: Text(strings.typeColorSectionTitle, style: theme.subtitleStyle(context)),
            leading: const SizedBox(),
          ),
          RadioListTile<NamedColorType>(
            isThreeLine: true,
            value: NamedColorType.basic,
            groupValue: settings.namedColorType,
            title: Text(strings.namedColorTypeRadioTitle[NamedColorType.basic]!),
            subtitle: Text(strings.namedColorTypeRadioSubtitle[NamedColorType.basic]!),
            onChanged: _onStandardSetChanged,
          ),
          RadioListTile<NamedColorType>(
            isThreeLine: true,
            value: NamedColorType.standard,
            groupValue: settings.namedColorType,
            title: Text(strings.namedColorTypeRadioTitle[NamedColorType.standard]!),
            subtitle: Text(strings.namedColorTypeRadioSubtitle[NamedColorType.standard]!),
            onChanged: _onStandardSetChanged,
          ),
          RadioListTile<NamedColorType>(
            isThreeLine: true,
            value: NamedColorType.extended,
            groupValue: settings.namedColorType,
            title: Text(strings.namedColorTypeRadioTitle[NamedColorType.extended]!),
            subtitle: Text(strings.namedColorTypeRadioSubtitle[NamedColorType.extended]!),
            onChanged: _onStandardSetChanged,
          ),
        ],
      ),
    );
  }
}
