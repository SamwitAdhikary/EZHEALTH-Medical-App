import 'dart:convert';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:ezhealth_app/config/palette.dart';
import 'package:ezhealth_app/screens/extra_screens/read_news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final String url =
      'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=a33b127053db4331819fc90114334461';

  List data;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson['articles'];
    });
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "HEALTH NEWS",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: data != null
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final myNews = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ReadNews(myNews['url'], myNews['title']),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: myNews['urlToImage'] != null
                            ? Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    height: 100,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              myNews['urlToImage']),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    // color: Colors.blue,
                                    child: AutoSizeText(
                                      myNews['title'],
                                      minFontSize: 15,
                                      maxFontSize: 18,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: AutoSizeText(
                                    myNews['title'],
                                    minFontSize: 20,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Lottie.asset("assets/animations/loading1.json"),
                ),
        ),
      ),
    );
  }
}
