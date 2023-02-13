import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../signin.dart';

class ConsumerDrawer extends StatefulWidget {
  const ConsumerDrawer({Key? key}) : super(key: key);

  @override
  State<ConsumerDrawer> createState() => _ConsumerDrawerState();
}

class _ConsumerDrawerState extends State<ConsumerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text("Logout"),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignIn()));
              });


            },
          )
        ],
      ),
    );
  }
}
