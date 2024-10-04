import 'package:dark_mode/src/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal(); // single instance

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGlobalCubit();
  }

  Widget _buildGlobalCubit() {
    return _buildMaterialApp();
  }

  Widget _buildMaterialApp() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: isDark,
          builder: (context, dark, child) {
            return MaterialApp(
              themeMode: dark ? ThemeMode.dark : ThemeMode.light,
              themeAnimationCurve: Curves.linear,
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue,
              ),
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
              ),
              themeAnimationDuration: const Duration(milliseconds: 500),
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
