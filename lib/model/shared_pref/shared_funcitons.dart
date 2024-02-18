import 'dart:developer';

import 'package:admin_ticead/model/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

// ======================================
// Setting Value to SharedPrefrence
// --------------------------------------

  static sharedprefset(String val) async {
    final value = await sharedInstance.setString(SCons.loginKey, val);
    log("sharedState Value sharedfunciton.dart ${value.toString()}");
  }

// ======================================
// Getting Value From SharedPrefrence
// --------------------------------------

  static String? sharedprefget() {
    return sharedInstance.getString(SCons.loginKey);
  }
}

// =============================================
// Made SharedPref StoredValue Availabale Globally
// ---------------------------------------------

late SharedPreferences sharedInstance;

sharedisntancefucniton() async {
  sharedInstance = await SharedPreferences.getInstance();
  log(sharedInstance.getString(SCons.loginKey).toString());
}
