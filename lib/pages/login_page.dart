import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/components/my_textfield.dart';
import 'package:p1/pages/home_page.dart';
import 'package:p1/service/auth/auth_service.dart';

class LoginPage extends StatefulWidget{
  final void Function()? onTap;
   const LoginPage({super.key,
     required this.onTap
  });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
    void login()async{
      //fill out authentication here
    final authService  =AuthService();
    //try sigin in
    try{
      await authService.singinWithEmailPassword(emailController.text,
          passwordController.text);
    }
    catch(e){
      showDialog(context: context,
          builder: (context)=>AlertDialog(
            title: Text(e.toString()),
          ));
    }

    //display any errors



      //navigate to home page


    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.lock_open_rounded,
            size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 25,),

            //meggase,app slogan

            Text("Food Delivery App",style: TextStyle(fontSize: 16,
            color: Theme.of(context).colorScheme.inversePrimary
            ),),
            const SizedBox(height: 25,),
            //
            MyTextfield(hintText:"Email" , obscureText: false, controller: emailController)
            //email text filed
           , const SizedBox(height: 10,),
            MyTextfield(
                hintText: "Password",
                obscureText:true,
                controller: passwordController),
            //sign in button
              MyButton(ontap: login,
                  text: "Sign in"),
            const SizedBox(height: 25,),
            //not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4,),

                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register now",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}