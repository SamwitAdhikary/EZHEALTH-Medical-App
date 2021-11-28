// import 'package:ezhealth_app/services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        // CircleAvatar(
        //   backgroundImage: NetworkImage(user.photoURL),
        //   radius: 35,
        // ),
        SizedBox(
          height: 20,
        ),
        Text(
          user.displayName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // SizedBox(
        //   height: 15,
        // ),
        Text(
          user.email,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 3,
        ),
        ListTile(
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 18),
          ),
          leading: Icon(Icons.logout),
          onTap: () {
            // final provider =
            //     Provider.of<GoogleSignInProvider>(context, listen: false);
            // provider.logout();
          },
        )
      ],
    );
  }
}
