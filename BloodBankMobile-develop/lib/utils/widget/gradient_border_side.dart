import 'package:flutter/material.dart';

class GradientBorderSide extends BorderSide {
  const GradientBorderSide({double strokeWidth = 1.0, required this.gradient, BorderStyle style = BorderStyle.solid})
      : super(color: Colors.transparent, width: strokeWidth, style: style);

  final Gradient gradient;

  static const GradientBorderSide none = GradientBorderSide(strokeWidth: 0.0, style: BorderStyle.none, gradient: LinearGradient(colors: [Colors.transparent]));

  @override
  Paint toPaint() {
    switch (style) {
      case BorderStyle.solid:
        return Paint()
          ..strokeWidth = width
          ..style = PaintingStyle.stroke
          ..shader = gradient.createShader(Rect.fromCenter(center: Offset.zero, width: width, height: width));
      case BorderStyle.none:
        return Paint()
          ..color = const Color(0x00000000)
          ..strokeWidth = 0.0
          ..style = PaintingStyle.stroke;
    }
  }
}
