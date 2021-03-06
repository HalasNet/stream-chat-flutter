import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

/// It shows a date divider depending on the date difference
class DateDivider extends StatelessWidget {
  final DateTime dateTime;

  const DateDivider({
    Key key,
    @required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final divider = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Divider(),
      ),
    );

    final createdAt = Jiffy(dateTime);
    final now = DateTime.now();
    final hourInfo = createdAt.format('h:mm a');

    String dayInfo;
    if (Jiffy(createdAt).isSame(now, Units.DAY)) {
      dayInfo = 'TODAY';
    } else if (Jiffy(createdAt)
        .isSame(now.subtract(Duration(days: 1)), Units.DAY)) {
      dayInfo = 'YESTERDAY';
    } else if (Jiffy(createdAt).isAfter(
      now.subtract(Duration(days: 7)),
      Units.DAY,
    )) {
      dayInfo = createdAt.format('EEEE').toUpperCase();
    } else if (Jiffy(createdAt).isAfter(
      Jiffy(now).subtract(years: 1),
      Units.DAY,
    )) {
      dayInfo = createdAt.format('dd/MM').toUpperCase();
    } else {
      dayInfo = createdAt.format('dd/MM/yyyy').toUpperCase();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        divider,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: dayInfo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' AT'),
                TextSpan(text: ' $hourInfo'),
              ],
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            style: TextStyle(
              fontSize: 10,
              color:
                  Theme.of(context).textTheme.headline6.color.withOpacity(.5),
            ),
          ),
        ),
        divider,
      ],
    );
  }
}
