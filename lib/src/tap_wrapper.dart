import 'package:flutter/material.dart';

/// {@template flutter_ok_widget.tap_wrapper}
///
/// Use [Material] and [InkWell] to wrap [child].
///
/// provider [color] and [padding]
///
/// {@endtemplate}
class TapWrapper extends StatelessWidget {
  /// [onTap] will be called when the widget is tapped.
  final VoidCallback onTap;

  /// [child] is the widget to wrap.
  final Widget child;

  /// [color] is the color of the [Material].
  final Color color;

  /// Wrapper [Padding] around [child].
  final EdgeInsets? padding;

  /// The [Material.elevation].
  final double elevation;

  /// {@macro flutter_ok_widget.tap_wrapper}
  const TapWrapper({
    Key? key,
    this.color = Colors.transparent,
    required this.onTap,
    required this.child,
    this.padding,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = child;

    if (padding != null) {
      w = Padding(padding: padding!, child: w);
    }

    return Material(
      color: color,
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        child: w,
      ),
    );
  }
}
