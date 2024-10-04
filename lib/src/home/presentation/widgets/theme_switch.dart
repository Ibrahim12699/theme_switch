import 'package:dark_mode/src/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({
    super.key,
    this.duration,
    this.curve,
    this.onChanged,
    this.isDark,
    this.width,
    this.height,
    this.liteBgColor,
    this.darkBgColor,
  });

  final Duration? duration;
  final Curve? curve;
  final Function(bool)? onChanged;
  final bool? isDark;
  final double? width;
  final double? height;
  final Color? liteBgColor;
  final Color? darkBgColor;

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  Duration duration = const Duration(milliseconds: 300);
  Curve curve = Curves.easeOut;
  double width = 48.r;
  double height = 24.r;
  Color liteBgColor = const Color(0xffC9F8FF);
  Color darkBgColor = const Color(0xff1C1C1E);
  Color liteBorderColor = const Color(0xff9E9E9E);
  Color darkBorderColor = const Color(0xff9E9E9E);

  ValueNotifier<bool> _valueNotifier = ValueNotifier<bool>(false);
  Duration opacityDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    duration = widget.duration ?? const Duration(milliseconds: 300);
    curve = widget.curve ?? Curves.easeOut;
    width = widget.width ?? 48.r;
    height = widget.height ?? 24.r;
    liteBgColor = widget.liteBgColor ?? const Color(0xffA4E7F7);
    darkBgColor = widget.darkBgColor ?? const Color(0xff1C1C1E);
    _valueNotifier = ValueNotifier<bool>(!(widget.isDark ?? false));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ThemeSwitch oldWidget) {
    duration = widget.duration ?? const Duration(milliseconds: 300);
    curve = widget.curve ?? Curves.easeOut;
    width = widget.width ?? 48.r;
    height = widget.height ?? 24.r;
    liteBgColor = widget.liteBgColor ?? const Color(0xffA4E7F7);
    darkBgColor = widget.darkBgColor ?? const Color(0xff1C1C1E);
    if (oldWidget.isDark != widget.isDark) {
      _valueNotifier.value = widget.isDark!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _valueNotifier,
      builder: (context, value, child) {
        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
          width: width,
          height: height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? darkBorderColor : liteBorderColor,
              width: (height * 0.05),
            ),
            borderRadius: BorderRadius.circular(width * 2),
            color: isDark ? darkBgColor : liteBgColor,
          ),
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: isDark ? liteBorderColor : darkBorderColor,
              width: (height * 0.05),
            ),
            borderRadius: BorderRadius.circular(width * 2),
          ),
          child: Stack(
            children: [
              _buildSunPosition(),
              _buildMoonPosition(),
              _buildCloud(),
              _buildStars(),
            ],
          )),
    );
  }

  Widget _buildSunPosition() {
    return AnimatedPositionedDirectional(
      top: (height * 0.15),
      bottom: (height * 0.15),
      duration: duration,
      curve: curve,
      start: isDark ? (width * 0.5) : (width * 0.08),
      child: AnimatedOpacity(
        duration: opacityDuration,
        curve: curve,
        opacity: isDark ? 0 : 1,
        child: _buildSunContainer(),
      ),
    );
  }

  Widget _buildSunContainer() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.r,
              spreadRadius: 8.r,
              color: const Color(0x1affda16),
              // blurStyle: BlurStyle.solid,
            ),
          ],
        ),
        child: _buildSunIcon(),
      ),
    );
  }

  Widget _buildSunIcon() {
    return SvgPicture.asset(
      AssetsManager.sun,
    );
  }

  Widget _buildMoonPosition() {
    return AnimatedPositionedDirectional(
      top: (height * 0.15),
      bottom: (height * 0.15),
      duration: duration,
      curve: curve,
      start: isDark ? (width * 0.62) : (width * 0.08),
      child: AnimatedOpacity(
        duration: opacityDuration,
        curve: curve,
        opacity: isDark ? 1 : 0,
        child: _buildMoonContainer(),
      ),
    );
  }

  Widget _buildMoonContainer() {
    return _buildMoonIcon();
  }

  Widget _buildMoonIcon() {
    return AspectRatio(
      aspectRatio: 1,
      child: SvgPicture.asset(
        AssetsManager.moon,
        matchTextDirection: true,
      ),
    );
  }

  Widget _buildCloud() {
    return AnimatedPositionedDirectional(
      duration: duration,
      top: (height * 0.3),
      bottom: 0,
      curve: curve,
      start: isDark ? -(width * 0.5) : (width * 0.2),
      child: SvgPicture.asset(
        AssetsManager.cloud,
        width: (width * 0.8),
        height: (height * 0.4),
      ),
    );
  }

  Widget _buildStars() {
    return AnimatedPositionedDirectional(
      duration: duration,
      top: isDark ? 0 : height,
      bottom: isDark ? 0 : -(height * 2),
      curve: curve,
      start: (width * 0.1),
      end: isDark ? (width * 0.4) : null,
      child: SvgPicture.asset(
        AssetsManager.stars,
        width: (width * 0.6),
        height: (height * 0.6),
      ),
    );
  }

  bool get isDark => _valueNotifier.value;

  void _onTap() {
    if (widget.onChanged != null) {
      _valueNotifier.value = !isDark;
      widget.onChanged!(!isDark);
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }
}
