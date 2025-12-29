import 'package:flutter/cupertino.dart';
import 'package:p1/pages/login_page.dart';
import 'package:p1/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({super.key});

  @override
  State<StatefulWidget> createState() =>_LoginOrRegisterState();
}
class _LoginOrRegisterState extends State<LoginOrRegister>{
  bool showLoginPage=true;
  void togglesPages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
      if(showLoginPage){
        return LoginPage(onTap: togglesPages);
      }else{
        return RegisterPage(onTap: togglesPages);
      }
  }
  
}