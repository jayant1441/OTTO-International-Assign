import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget(
      {
        required this.child,
        required this.gradient,
        this.style,
      });

  final Widget child;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}