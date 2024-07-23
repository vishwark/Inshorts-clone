import 'package:flutter/material.dart';
import 'package:inshorts_clone/presentation_layer/widgets/settings.dart';
import 'package:inshorts_clone/presentation_layer/widgets/sign_in_options.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Settings(),
    );
  }
}
