import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tuncforworkalt/constants/app_constants.dart';
import 'package:tuncforworkalt/controllers/exports.dart';
import 'package:tuncforworkalt/views/common/drawer/drawer_screen.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/ui/auth/profile.dart';
import 'package:tuncforworkalt/views/ui/bookmarks/bookmarks.dart';
import 'package:tuncforworkalt/views/ui/device_mgt/devices_info.dart';
import 'package:tuncforworkalt/views/ui/homepage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
          menuScreen: DrawerScreen(
            indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            },
          ),
          mainScreen: currentSreen(),
          borderRadius: 30,
          showShadow: true,
          angle: 0.0,
          slideWidth: 250,
          menuBackgroundColor: Color(AppConstants.kLightBlue.value),
        );
      },
    );
  }

  Widget currentSreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const HomePage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagement();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
