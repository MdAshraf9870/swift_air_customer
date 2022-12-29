import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConst{
  static var buttonColors=const Color(0xfff5271ff);
  static var buttonColorsDark=const Color(0xfff6d7ab5);
  static var buttonCorsDark=const Color(0xfff6d7ab5);
  Future<String> getCalenderDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      return DateFormat('dd-MMM-yyyy').format(pickedDate);
    } else {
      return "";
    }
  }
  Future<String> getTimePicker(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      return time.format(context);
    } else {
      return "";
    }
  }

}