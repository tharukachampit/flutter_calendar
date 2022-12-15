// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../typedefs.dart';

class CalendarPageHeader extends StatelessWidget {
  /// When user taps on right arrow.
  final VoidCallback? onNextDay;

  /// When user taps on left arrow.
  final VoidCallback? onPreviousDay;

  /// When user taps on title.
  final AsyncCallback? onTitleTapped;

  /// Date of month/day.
  final DateTime date;

  /// Secondary date. This date will be used when we need to define a
  /// range of dates.
  /// [date] can be starting date and [secondaryDate] can be end date.
  final DateTime? secondaryDate;

  /// Provides string to display as title.
  final StringProvider dateStringBuilder;

  /// backgeound color of header.
  final Color backgroundColor;

  /// Color of icons at both sides of header.
  final Color iconColor;

  final Color textColor;
  final double? fontSize;

  final bool showTopDate;

  /// Common header for month and day view In this header user can define format
  /// in which date will be displayed by providing [dateStringBuilder] function.
  const CalendarPageHeader({
    Key? key,
    required this.date,
    required this.dateStringBuilder,
    this.onNextDay,
    this.onTitleTapped,
    this.onPreviousDay,
    this.secondaryDate,
    this.backgroundColor = Constants.headerBackground,
    this.iconColor = Constants.black,
    this.textColor = Colors.white,
    this.showTopDate = false,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: (MediaQuery.of(context).size.height / 90),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: onPreviousDay,
                  customBorder: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2D781A),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chevron_left,
                        size: fontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: InkWell(
                    onTap: onTitleTapped,
                    child: Text(
                      "Today",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onNextDay,
                  customBorder: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2D781A),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chevron_right,
                        size: fontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showTopDate)
            LayoutBuilder(builder: (context, cons) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: (cons.biggest.width / 6) + 16,
                ),
                child: Text(
                  DateFormat().add_MMMMEEEEd().format(date),
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                  ),
                ),
              );
            })
        ],
      ),
    );
  }
}
