import 'dart:math' as math;

import '../../../../app/app_preferences.dart';
import '../../../../app/di.dart';
import '../../../../data/data_sourse/local_data_source.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/langauges_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final AppsPreferences _appsPreferences = instance<AppsPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          _buildItem(
              title: AppStrings.changeLanguage.tr(),
              leading: ImageAssets.changeLangIc,
              onTap: _changeLanguage),
          _buildItem(
              title: AppStrings.contactUs.tr(),
              leading: ImageAssets.contactUsIc,
              onTap: _contactUs),
          _buildItem(
              title: AppStrings.inviteYourFriend.tr(),
              leading: ImageAssets.inviteFriendsIc,
              onTap: _inviteFriend),
          _buildItem(
              title: AppStrings.logout.tr(),
              leading: ImageAssets.logoutIc,
              onTap: _logout),
        ],
      ),
    );
  }

  _buildItem({
    required String title,
    required String leading,
    required void Function()? onTap,
  }) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      leading: SvgPicture.asset(leading),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge,
      ),
      trailing: Transform(
        transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
        child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
      ),
      onTap: onTap,
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCALE;
  }

  void _changeLanguage() {
    _appsPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}

  void _inviteFriend() {}

  void _logout() {
    _appsPreferences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
