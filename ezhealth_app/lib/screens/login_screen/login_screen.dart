import 'package:ezhealth_app/screens/doctor_screen/doctor_screen.dart';
import 'package:ezhealth_app/screens/user_screen/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisible;
  String errorMessage;
  bool isLogin = false;

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference().child("Users");

  String emailText;
  String passwordText;

  final _email = TextEditingController();
  final _password = TextEditingController();

  void _reset() {
    _email.clear();
    _password.clear();
  }

  void _signIn() async {
    try {
      setState(() {
        isLogin = true;
      });
      final newUser = await _auth.signInWithEmailAndPassword(
          email: emailText, password: passwordText);

      if (newUser != null) {
        // print('Success');
        final User user = FirebaseAuth.instance.currentUser;
        final userId = user.uid;

        await FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(userId)
            .once()
            .then((DataSnapshot snapshot) {
          setState(() {
            if (snapshot.value['role'] == 'Doctor') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorScreen(userId)));
            } else if (snapshot.value['role'] == 'User') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            }
          });
        });

        print(userId);
      } else {
        print('Failed');
        // isLogin = false;
      }
    } catch (error) {
      // isLogin = false;
      setState(() {
        isLogin = false;
      });
      print(error);

      String errorText = getMessageFromErrorCode(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorText)));
    }
  }

  String getMessageFromErrorCode(error) {
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        isLogin = false;
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        isLogin = false;
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        isLogin = false;
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        isLogin = false;
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        isLogin = false;
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        isLogin = false;
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        isLogin = false;
        return "Email address is invalid.";
        break;
      default:
        isLogin = false;
        return "Login failed. Please try again.";
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  "Login Page",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //! Email
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Email"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        validator: emailValidate,
                        onSaved: (value) {
                          emailText = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //! Password
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Password"),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(_isVisible == false
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: !_isVisible,
                        obscuringCharacter: "*",
                        controller: _password,
                        validator: passwordValidate,
                        onSaved: (value) {
                          passwordText = value;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      isLogin == false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      _signIn();
                                    }
                                    FocusScope.of(context).unfocus();

                                    print(emailText);
                                    print(passwordText);
                                  },
                                  child: Text("Login"),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _reset();
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Text("Reset"),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String emailValidate(String email) {
    if (email.isEmpty) {
      return "Email must not be empty";
    } else {
      return null;
    }
  }

  String passwordValidate(String password) {
    if (password.isEmpty) {
      return "Password mus not be empty";
    } else {
      return null;
    }
  }
}
