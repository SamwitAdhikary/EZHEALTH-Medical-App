// import 'package:ezhealth_app/services/google_sign_in.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  // final provider =
                      // Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.googleLogin();
                },
                child: Icon(Icons.login)),
          ),
        ),
      ),
    );
  }
}
