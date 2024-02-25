import 'dart:developer';

import 'package:admin_ticead/model/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref.internal();
  static SharedPref sharedIn=SharedPref.internal();
  factory SharedPref(){
    return sharedIn;
  }

  String sharedInstance ='';

Future<void>sharedisntancefucniton() async {
  final temp = await SharedPreferences.getInstance();
  sharedInstance = temp.getString(SCons.loginKey)!;
}



// ======================================
// Setting Value to SharedPrefrence
// --------------------------------------

  static sharedprefset(String val) async {
    final value = await SharedPreferences.getInstance();
    value.setString(SCons.loginKey, val);
    log("sharedState Value sharedfunciton.dart ${value.toString()}");
  }

// ======================================
// Getting Value From SharedPrefrence
// --------------------------------------

  static Future<String?> sharedprefget() async{
     final value = await SharedPreferences.getInstance();
    return value.getString(SCons.loginKey);
  }
}

// =============================================
// Made SharedPref StoredValue Availabale Globally
// ---------------------------------------------



// sharedisntancefucniton() async {
//   sharedInstance = await SharedPreferences.getInstance();
//   log(sharedInstance.getString(SCons.loginKey).toString());
// }
