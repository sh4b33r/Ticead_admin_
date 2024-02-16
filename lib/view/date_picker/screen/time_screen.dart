import 'package:admin_ticead/view/date_picker/widget/date_tabbar.dart';
import 'package:flutter/material.dart';

class DateMainPage extends StatelessWidget {
  const DateMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SingleChildScrollView(

      child:DateWidget()



    ),);
  }
}