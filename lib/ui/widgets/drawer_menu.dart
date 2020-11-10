import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nix_notes/core/services/auth_service.dart';
import 'package:nix_notes/ui/screens/home_screen.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Theme(
        data: ThemeData.dark(),
        child: Material(
          color:Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(right:12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 15, top: 15,right: 10),
                      child: Row(
                        children: [
                          RichText(
                            textScaleFactor: 1.8,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Sticky',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: ' Notes',
                                    style: TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                      // decoration: BoxDecoration(
                      //     color: Colors.deepOrangeAccent,
                      //     borderRadius: BorderRadius.only(
                      //         topRight: Radius.circular(100),
                      //         bottomRight: Radius.circular(100))),
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>HomeScreen()), (route) => false);
                        },
                          leading: Icon(Icons.lightbulb_outline),
                          title: Text("Notes"))),
                ),
                // ListTile(
                //   onTap: (){
                //     Fluttertoast.showToast(
                //         msg: "Reminders Coming Soon...",
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.BOTTOM,
                //         timeInSecForIosWeb: 2,
                //         backgroundColor: Colors.deepOrangeAccent,
                //         textColor: Colors.white,
                //         fontSize: 16.0
                //     );
                //   },
                //   leading: Icon(Icons.notifications_none_outlined),
                //   title: Text("Reminders"),
                // ),
                // Divider(
                //   thickness: 1.5,
                // ),
                // ListTile(
                //   onTap: (){},
                //   leading: Icon(Icons.add),
                //   title: Text("Create new label"),
                // ),
                // Divider(
                //   thickness: 1.5,
                // ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen(location: "Archive",)));
                  },
                  leading: Icon(Icons.archive_outlined),
                  title: Text("Archive"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen(location: "Trash",)));
                  },
                  leading: Icon(Icons.delete_outlined),
                  title: Text("Trash"),
                ),
                Divider(
                  thickness: 1.5,
                ),
                ListTile(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>AuthService.instance.handleAuth()), (route) => false);
                    FirebaseAuth.instance.signOut();
                  },
                  leading: Icon(Icons.logout),
                  title: Text("Log out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
