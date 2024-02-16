import 'dart:developer';

import 'package:admin_ticead/model/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> sharedprefset(String val) async {
    final shared = await SharedPreferences.getInstance();
    final value = shared.setString(SCons.loginKey, val);
    log("sharedState Value sharedfunciton.dart ${value.toString()}");
  }

  static Future<String?> sharedprefget() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(SCons.loginKey);
  }
}
