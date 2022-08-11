import 'package:ezhealth_app/screens/doctor_screen/doctor_screen.dart';
import 'package:ezhealth_app/screens/user/user_dashboard/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  String emailText;
  String passwordText;

  bool _isPasswordVisible;
  bool isLogin = false;

  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference().child("Users");

  void _signIn() async {
    try {
      setState(() {
        isLogin = true;
      });
      final newUser = await _auth.signInWithEmailAndPassword(
          email: emailText, password: passwordText);

      if (newUser != null) {
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
              setDoctorDetails(userId);
              Navigator.pushReplacement(
                context,
                PageTransition(
                    child: ShowCaseWidget(
                      builder:
                          Builder(builder: (context) => DoctorScreen(userId)),
                    ),
                    type: PageTransitionType.rightToLeftWithFade),
              );
            } else if (snapshot.value['role'] == 'User') {
              setUserDetails(userId);
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: ShowCaseWidget(
                        builder:
                            Builder(builder: (context) => UserHome(userId)),
                      ),
                      type: PageTransitionType.rightToLeftWithFade));
            }
          });
        });
        print(userId);
      } else {
        print('Failed');
      }
    } catch (error) {
      setState(() {
        isLogin = false;
      });
      print(error);

      String errorText = getMessageFromErrorCode(error);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Error"),
          content: Text(errorText),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
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

  setDoctorDetails(String doctorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', 'Doctor');
    prefs.setString('doctorId', doctorId);
  }

  setUserDetails(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', 'User');
    prefs.setString('userId', userId);
  }

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Lottie.asset('assets/animations/login.json'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //! Email Field
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Enter email id",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: _email,
                          validator: emailValidate,
                          onSaved: (value) {
                            emailText = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //! Password Field
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Enter password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(_isPasswordVisible != true
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          obscureText: !_isPasswordVisible,
                          obscuringCharacter: "\u2749",
                          textInputAction: TextInputAction.go,
                          controller: _password,
                          validator: passwordValidate,
                          onSaved: (value) {
                            passwordText = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                isLogin == false
                    ? ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _signIn();
                          }
                          print(emailText);
                          print(passwordText);

                          FocusScope.of(context).unfocus();
                        },
                        child: Text('Login'))
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String emailValidate(String email) {
    if (email.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }

  String passwordValidate(String password) {
    if (password.isEmpty) {
      return 'Field must not be empty';
    } else {
      return null;
    }
  }
}
