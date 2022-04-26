import 'package:flutter/material.dart';

/// {@template flutter_ok_widget.ok_table_theme}
///
/// Use [OKTableTheme] to customize the [TableMixin].
///
/// {@endtemplate}
class OKTableTheme extends InheritedWidget {
  /// {@macro flutter_ok_widget.ok_table_theme_data}
  final OKTableThemeData dark;
  final OKTableThemeData light;

  /// {@macro flutter_ok_widget.ok_table_theme}
  const OKTableTheme({
    Key? key,
    required Widget child,
    required this.dark,
    required this.light,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is OKTableTheme) {
      return oldWidget.dark != dark || oldWidget.light != light;
    }

    return false;
  }

  static OKTableThemeData of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = context.dependOnInheritedWidgetOfExactType<OKTableTheme>();
    if (theme == null) {
      return OKTableThemeData.fallback(brightness: brightness);
    }
    if (brightness == Brightness.dark) {
      return theme.dark;
    }
    return theme.light;
  }

  static const defaultTheme = OKTableThemeData.defaultTheme;
}

/// {@template flutter_ok_widget.ok_table_theme_data}
///
/// Use [OKTableThemeData] to customize the [TableMixin].
///
/// {@endtemplate}
class OKTableThemeData {
  /// The [TextStyle] of the [TableMixin] header.
  final TextStyle titleStyle;

  /// The [TextStyle] of the [TableMixin] content.
  final TextStyle bodyStyle;

  /// {@macro flutter_ok_widget.ok_table_theme_data}
  const OKTableThemeData({
    required this.titleStyle,
    required this.bodyStyle,
  });

  /// The default theme.
  static const defaultTheme = lightTheme;

  /// Default dark theme
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

  /// Default light theme
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

  static OKTableThemeData fallback({required Brightness brightness}) {
    switch (brightness) {
      case Brightness.dark:
        return darkTheme;
      case Brightness.light:
        return lightTheme;
      default:
        return defaultTheme;
    }
  }
}
