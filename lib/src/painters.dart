// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as timeFormatter;

import 'constants.dart';

/// Paints 24 hour lines.
class HourLinePainter extends CustomPainter {
  /// Color of hour line
  final Color lineColor;

  /// Height of hour line
  final double lineHeight;

  /// Offset of hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Flag to display vertical line at left or not.
  final bool showVerticalLine;

  /// left offset of vertical line.
  final double verticalLineOffset;

  /// Paints 24 hour lines.
  HourLinePainter({
    required this.lineColor,
    required this.lineHeight,
    required this.minuteHeight,
    required this.offset,
    required this.showVerticalLine,
    this.verticalLineOffset = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    for (var i = 1; i < Constants.hoursADay; i++) {
      final dy = i * minuteHeight * 60;
      canvas.drawLine(Offset(offset, dy), Offset(size.width, dy), paint);
    }

    if (showVerticalLine)
      canvas.drawLine(Offset(offset + verticalLineOffset, 0),
          Offset(offset + verticalLineOffset, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourLinePainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight ||
            showVerticalLine != oldDelegate.showVerticalLine);
  }
}

/// Paints a single horizontal line at [offset].
class CurrentTimeLinePainter extends CustomPainter {
  /// Color of time indicator.
  final Color color;

  /// Height of time indicator.
  final double height;

  /// offset of time indicator.
  final Offset offset;

  /// Flag to show bullet at left side or not.
  final bool showBullet;

  /// Radius of bullet.
  final double bulletRadius;

  final DateTime time;

  /// Paints a single horizontal line at [offset].
  CurrentTimeLinePainter({
    this.showBullet = true,
    required this.color,
    required this.height,
    required this.offset,
    this.bulletRadius = 12,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy),
      Offset(size.width, offset.dy),
      Paint()
        ..color = color
        ..strokeWidth = height,
    );

    if (showBullet) {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromCircle(
            center: Offset(offset.dx, offset.dy),
            radius: bulletRadius,
          ),
          bottomLeft: Radius.circular(bulletRadius * 2 / 3),
          bottomRight: Radius.circular(bulletRadius * 2 / 3),
          topLeft: Radius.circular(bulletRadius * 2 / 3),
          topRight: Radius.circular(bulletRadius * 2 / 3),
        ),
        Paint()..color = color,
      );

      final textSize = bulletRadius * 2 * 4 / 5;

      final textSpan = TextSpan(
        children: [
          TextSpan(
            text: "${timeFormatter.DateFormat('h:mm').format(time)}\n",
            style: TextStyle(fontSize: textSize * 2 / 6),
          ),
          TextSpan(text: timeFormatter.DateFormat('a').format(time)),
        ],
        style: TextStyle(fontSize: textSize * 2 / 5, color: Colors.white),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )
        ..layout(
          maxWidth: bulletRadius * 2,
        )
        ..paint(
          canvas,
          Offset(
            offset.dx - bulletRadius * 2 / 3,
            offset.dy - bulletRadius * 2 / 3,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is CurrentTimeLinePainter &&
      (color != oldDelegate.color ||
          height != oldDelegate.height ||
          offset != oldDelegate.offset);
}
