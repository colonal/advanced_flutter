import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.setting),
    );
  }
}
