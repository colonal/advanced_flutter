import 'package:advanced_flutter/presentation/main/pages/home/view/home_page.dart';
import 'package:advanced_flutter/presentation/main/pages/notification/notification_page.dart';
import 'package:advanced_flutter/presentation/main/pages/search/search_page.dart';
import 'package:advanced_flutter/presentation/main/pages/setting/setting_page.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    Setting()
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.setting,
  ];

  String _title = AppStrings.home;
  int _curreuntIndex = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: theme.textTheme.titleSmall,
        ),
      ),
      body: pages[_curreuntIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorManager.grey.withOpacity(0.4),
                spreadRadius: AppSize.s1_5),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _curreuntIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notification),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.setting),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _curreuntIndex = index;
      _title = titles[index];
    });
  }
}
