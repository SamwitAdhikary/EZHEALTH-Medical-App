import 'package:ezhealth_app/screens/extra_screens/restart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/offline.json',
              ),
              Text(
                'No Internet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  RestartWidget.restartApp(context);
                },
                child: Text('Restart App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
