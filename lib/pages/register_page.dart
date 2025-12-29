import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/components/my_textfield.dart';
import 'package:p1/service/auth/auth_service.dart';

class RegisterPage extends StatefulWidget{
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
});

  @override
  State<StatefulWidget> createState() =>_RegisterPageState();
  }
  class _RegisterPageState extends State<RegisterPage>{
      final TextEditingController emailController=TextEditingController();
    final TextEditingController passwordController=TextEditingController();
    final TextEditingController confirmPasswordController=TextEditingController();
    void register()async{
      final authService=AuthService();
      //password
      if(passwordController.text==confirmPasswordController.text){
        //
        try{
          await authService.sigupUpWithEmailPassword(emailController.text, passwordController.text);
        }
        catch(e){
          showDialog(context: context,
              builder: (context)=>AlertDialog(
                title: Text(e.toString()),
              ));
        }
      }else{
        showDialog(context: context,
            builder: (context)=>AlertDialog(
              title: Text("Password do not match"),
            ));
      }
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

            Text("Let's create an account",style: TextStyle(fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary
            ),),
            const SizedBox(height: 25,),
            //
            MyTextfield(hintText:"Email" , obscureText: false, controller: emailController)

            //email text filed
            , const SizedBox(height: 10,),
            MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: passwordController),
         const SizedBox(height: 10,),
             MyTextfield(
          hintText: "Confirm password",
          obscureText: true,
          controller: confirmPasswordController),
            //sign in button
            MyButton(
                ontap: register,
                text: "Sign up"),
            const SizedBox(height: 25,),
            //not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ?",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4,),
                GestureDetector(
                  onTap:register,
                  child: Text("Login now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
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