import 'package:dark_mode/src/app/app.dart';
import 'package:dark_mode/src/home/presentation/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          32.verticalSpace,
          _buildThemeSwitch(),
          32.verticalSpace,
          _buildLabel(),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (context, dark, child) {
        return Text(
          dark ? 'Dark' : 'Light',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  Widget _buildThemeSwitch() {
    return ThemeSwitch(
      isDark: isDark.value,
      height: 84.r,
      width: 168.r,
      duration: const Duration(milliseconds: 500),
      onChanged: _onThemeSwitchChanged,
    );
  }

  void _onThemeSwitchChanged(bool value) {
    isDark.value = value;
  }
}
