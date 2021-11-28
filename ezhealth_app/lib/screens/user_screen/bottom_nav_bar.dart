import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/user_screen/bmi.dart';
import 'package:ezhealth_app/screens/user_screen/chat_bot.dart';
import 'package:ezhealth_app/screens/user_screen/corona_stats.dart';
import 'package:ezhealth_app/screens/user_screen/news.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  final News news = News();
  final CoronaStats coronaStats = CoronaStats();
  final BMIScreen bmiScreen = BMIScreen();

  Widget _showPage = CoronaStats();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return coronaStats;
        break;
      case 1:
        return news;
        break;
      case 2:
        return bmiScreen;
        break;
      default:
        return new Container(
          child: Center(
            child: Text(
              "No Page To Show",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(),
        bottomNavigationBar: CurvedNavigationBar(
          index: pageIndex,
          height: 60.0,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 35,
            ),
            FaIcon(
              FontAwesomeIcons.virus,
              size: 35,
            ),
            FaIcon(
              FontAwesomeIcons.weight,
              size: 35,
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Palette.scaffoldColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (int tapped) {
            setState(() {
              _showPage = _pageChooser(tapped);
            });
          },
        ),
        body: Container(
          child: _showPage,
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            elevation: 10,
            tooltip: "Chat With Bot",
            child: FaIcon(
              FontAwesomeIcons.robot,
              color: Colors.blue,
            ),
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatBot()));
            },
          ),
        ),
      ),
    );
  }
}
