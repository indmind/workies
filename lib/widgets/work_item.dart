import 'package:flutter/material.dart';
import 'package:workies/models/work.dart';
import 'package:intl/intl.dart';
import 'package:workies/painters/long_arrow.dart';

class WorkItem extends StatelessWidget {
  final Work work;

  WorkItem({
    @required this.work,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    DateTime startDate = work.start_date?.toDate();
    DateTime endDate = work.end_date?.toDate();

    print("rendering ${work.message}");

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 8,
          bottom: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xaaffffff),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 10,
                offset: Offset(0, 2.5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat('EEEE').format(startDate),
                  style: textTheme.title,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  work.message,
                  style: textTheme.body1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      DateFormat("HH:mm").format(startDate),
                      style: textTheme.body1,
                    ),
                    CustomPaint(
                      painter: LongArrowPainter(),
                    ),
                    Text(
                      DateFormat("HH:mm").format(endDate),
                      style: textTheme.body1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
