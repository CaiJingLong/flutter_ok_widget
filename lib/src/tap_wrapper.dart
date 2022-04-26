import 'package:flutter/material.dart';

/// {@template flutter_ok_widget.tap_wrapper}
///
/// Use [Material] and [InkWell] to wrap [child].
///
/// provider [color] and [padding]
///
/// {@endtemplate}
class TapWrapper extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color color;
  final EdgeInsets? padding;

  /// {@macro flutter_ok_widget.tap_wrapper}
  const TapWrapper({
    Key? key,
    this.color = Colors.transparent,
    required this.onTap,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = child;

    if (padding != null) {
      w = Padding(padding: padding!, child: w);
    }

    return Material(
      color: color,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: w,
      ),
    );
  }
}
