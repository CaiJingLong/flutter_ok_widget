import 'package:flutter/material.dart';

class OKTableTheme extends InheritedWidget {
  final OKTableThemeData data;

  const OKTableTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is OKTableTheme) {
      return data != oldWidget.data;
    }
    return false;
  }

  static OKTableTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OKTableTheme>();

  static const defaultTheme = OKTableThemeData.defaultTheme;
}

class OKTableThemeData {
  final TextStyle titleStyle;
  final TextStyle bodyStyle;

  const OKTableThemeData({
    required this.titleStyle,
    required this.bodyStyle,
  });

  static const defaultTheme = lightTheme;

  static const darkTheme = OKTableThemeData(
    titleStyle: TextStyle(
      fontSize: 14,
      color: Color(0xFFCCCCCC),
    ),
    bodyStyle: TextStyle(
      fontSize: 12,
      color: Color(0xFFCCCCCC),
    ),
  );

  static const lightTheme = OKTableThemeData(
    titleStyle: TextStyle(
      fontSize: 14,
      color: Color(0xFF333333),
    ),
    bodyStyle: TextStyle(
      fontSize: 12,
      color: Color(0xFF333333),
    ),
  );

  OKTableThemeData copyWith({
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
  }) {
    return OKTableThemeData(
      titleStyle: titleStyle ?? this.titleStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
    );
  }
}
