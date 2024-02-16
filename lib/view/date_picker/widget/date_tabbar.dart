import 'package:admin_ticead/view/theme/color_theme/main_colors.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(top: 10),
      child: DatePicker(
      DateTime.now(),
      
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: MycolorTheme.custwhite,
      
      selectedTextColor: Colors.red,
      deactivatedColor: Color.fromARGB(255, 235, 233, 233),
    //   activeDates: [],
    // inactiveDates: [],
      dateTextStyle: MytextTheme.commomText
      
      
      ),
    );
  }
}