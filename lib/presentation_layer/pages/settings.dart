import 'package:flutter/material.dart';
import 'package:inshorts_clone/presentation_layer/widgets/settings.dart';
import 'package:inshorts_clone/presentation_layer/widgets/sign_in_options.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Settings(),
    );
  }
}
