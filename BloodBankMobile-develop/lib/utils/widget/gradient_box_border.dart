import 'package:flutter/widgets.dart';

import 'gradient_border_side.dart';

class GradientBoxBorder extends BoxBorder {
  const GradientBoxBorder({
    this.top = GradientBorderSide.none,
    this.right = GradientBorderSide.none,
    this.bottom = GradientBorderSide.none,
    this.left = GradientBorderSide.none,
  });

  @override
  final GradientBorderSide top;

  /// The right side of this border.
  final GradientBorderSide right;

  @override
  final GradientBorderSide bottom;

  /// The left side of this border.
  final GradientBorderSide left;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.fromLTRB(left.width, top.width, right.width, bottom.width);
  }

  @override
  bool get isUniform => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    paintBorder(canvas, rect, top: top, left: left, right: right, bottom: bottom);
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }

  void paintBorder(
    Canvas canvas,
    Rect rect, {
    GradientBorderSide top = GradientBorderSide.none,
    GradientBorderSide right = GradientBorderSide.none,
    GradientBorderSide bottom = GradientBorderSide.none,
    GradientBorderSide left = GradientBorderSide.none,
  }) {
    final Path path = Path();

    switch (top.style) {
      case BorderStyle.solid:
        final Paint paint = Paint()
          ..strokeWidth = top.width
          ..shader = top.gradient.createShader(Rect.fromLTWH(0, 0, rect.right, top.width));
        path.reset();
        path.moveTo(rect.left, rect.top);
        path.lineTo(rect.right, rect.top);
        if (top.width == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;
          path.lineTo(rect.right - right.width, rect.top + top.width);
          path.lineTo(rect.left + left.width, rect.top + top.width);
        }
        canvas.drawPath(path, paint);
        break;
      case BorderStyle.none:
        break;
    }

    switch (right.style) {
      case BorderStyle.solid:
        final Paint paint = Paint()
          ..strokeWidth = right.width
          ..shader = right.gradient.createShader(Rect.fromLTWH(0, 0, right.width, rect.bottom));
        path.reset();
        path.moveTo(rect.right, rect.top);
        path.lineTo(rect.right, rect.bottom);
        if (right.width == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;
          path.lineTo(rect.right - right.width, rect.bottom - bottom.width);
          path.lineTo(rect.right - right.width, rect.top + top.width);
        }
        canvas.drawPath(path, paint);
        break;
      case BorderStyle.none:
        break;
    }

    switch (bottom.style) {
      case BorderStyle.solid:
        final Paint paint = Paint()
          ..strokeWidth = bottom.width
          ..shader = bottom.gradient.createShader(Rect.fromLTWH(0, 0, rect.bottom, bottom.width));
        path.reset();
        path.moveTo(rect.right, rect.bottom);
        path.lineTo(rect.left, rect.bottom);
        if (bottom.width == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;
          path.lineTo(rect.left + left.width, rect.bottom - bottom.width);
          path.lineTo(rect.right - right.width, rect.bottom - bottom.width);
        }
        canvas.drawPath(path, paint);
        break;
      case BorderStyle.none:
        break;
    }

    switch (left.style) {
      case BorderStyle.solid:
        final Paint paint = Paint()
          ..strokeWidth = left.width
          ..shader = left.gradient.createShader(Rect.fromLTWH(0, 0, left.width, rect.bottom));
        path.reset();
        path.moveTo(rect.left, rect.bottom);
        path.lineTo(rect.left, rect.top);
        if (left.width == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;
          path.lineTo(rect.left + left.width, rect.top + top.width);
          path.lineTo(rect.left + left.width, rect.bottom - bottom.width);
        }
        canvas.drawPath(path, paint);
        break;
      case BorderStyle.none:
        break;
    }
  }
}
