import 'package:admin_ticead/controller/login_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';

class LoginScreen extends StatelessWidget {
   const LoginScreen({super.key});
   
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Scaffold(
        body:
        
         SingleChildScrollView(
      // physics:NeverScrollableScrollPhysics(),
      child: Column(
 crossAxisAlignment: CrossAxisAlignment.center,
//  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'asset/image/logotiecad.png',
                height: 90,
                width: 60,
              ),
            ),

            SignInButton(buttonType: ButtonType.google, onPressed:()async{

                 await  controller.tologin();
              // Get.off( () => const HOmeScreen());
            })

          ]),

    

    )
    
    );
  }
}
