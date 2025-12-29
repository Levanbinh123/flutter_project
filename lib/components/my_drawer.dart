import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/components/my_drawer_title.dart';
import 'package:p1/pages/settings_page.dart';
import 'package:p1/service/auth/auth_service.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});
void logout(){
  final authService=AuthService();
  authService.signOut();
}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),


          //home list title
          MyDrawerTitle(text: "H O M E",
              icon: Icons.home,
              onTap: ()=>Navigator.pop(context)),

          MyDrawerTitle(text: "S E T T I N G S",
              icon: Icons.settings,
              onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsPage()));
              }),
const Spacer(),
          MyDrawerTitle(text: "L O G G O U T",
              icon: Icons.logout,
              onTap: logout),
          const SizedBox(height: 25,)





        ],
      ),
    );
  }
}