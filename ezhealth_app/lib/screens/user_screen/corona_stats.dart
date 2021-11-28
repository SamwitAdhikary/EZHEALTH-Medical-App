import 'dart:convert';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class CoronaStats extends StatefulWidget {
  @override
  _CoronaStatsState createState() => _CoronaStatsState();
}

class _CoronaStatsState extends State<CoronaStats> {
  final String url =
      'https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true';

  Map data;
  List state;

  @override
  void initState() {
    super.initState();
    fetchCorona();
  }

  fetchCorona() async {
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson;
      state = convertJson['regionData'];
    });
    print(state.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("EZHEALTH"),
      // ),
      body: data != null
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  stats(
                    "Total Cases",
                    "Total Active",
                    data['totalCases'].toString(),
                    "",
                    data['activeCases'].toString(),
                    data['activeCasesNew'].toString(),
                    false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  stats(
                    "Total Recovered",
                    "Total Deaths",
                    data['recovered'].toString(),
                    data['recoveredNew'].toString(),
                    data['deaths'].toString(),
                    data['deathsNew'].toString(),
                    true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.93,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          offset: Offset(3.0, 3.0),
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          height: 80,
                          width: MediaQuery.of(context).size.width * 0.5,
                          // color: Colors.red,
                          child: AutoSizeText(
                            "TOTAL SAMPLES TESTED",
                            // style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            minFontSize: 18,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.43,
                              padding: EdgeInsets.only(right: 10, top: 10),
                              height: 45,
                              // color: Colors.red,
                              child: Text(
                                data['previousDayTests'].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 30,
                              padding: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width * 0.43,

                              // color: Colors.pink,
                              child: GestureDetector(
                                onTap: () {
                                  print("Clicked on source");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Source"),
                                    Icon(
                                      Icons.open_in_new,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // height: 700,
                    width: MediaQuery.of(context).size.width * 0.93,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          offset: Offset(3.0, 3.0),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 10, top: 20),
                          // color: Colors.red,
                          child: Text(
                            "STATE WISE DATA",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                "COMPILED FROM STATE GOVT.\nNUMBERS AND VERIFIED SOURCES",
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Know More"),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 11,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 20,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                // color: Colors.red,
                                child: Text("State/UT"),
                              ),
                              Container(
                                width: 70,
                                // color: Colors.red,
                                child: Center(
                                  child: Text("Confirm"),
                                ),
                              ),
                              Container(
                                width: 70,
                                // color: Colors.red,
                                child: Center(
                                  child: Text("Active"),
                                ),
                              ),
                              Container(
                                width: 70,
                                // color: Colors.red,
                                child: Center(
                                  child: Text("Recover"),
                                ),
                              ),
                              Container(
                                width: 70,
                                // color: Colors.red,
                                child: Center(
                                  child: Text("Death"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.length,
                          itemBuilder: (BuildContext context, int index) {
                            final myState = state[index];
                            return Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        width: 80,
                                        // color: Colors.red,
                                        child: AutoSizeText(
                                          myState['region'],
                                          maxLines: 2,
                                          minFontSize: 9,
                                          maxFontSize: 11,
                                        ),
                                      ),
                                      Container(
                                        width: 70,
                                        // color: Colors.red,
                                        child: Center(
                                          child: Text(
                                            myState['totalInfected'].toString(),
                                            style: TextStyle(fontSize: 11.5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: 70,
                                          // color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              myState['activeCases'].toString(),
                                              style: TextStyle(fontSize: 11.5),
                                            ),
                                          )),
                                      Container(
                                          width: 70,
                                          // color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              myState['recovered'].toString(),
                                              style: TextStyle(
                                                fontSize: 11.5,
                                              ),
                                            ),
                                          )),
                                      Container(
                                          width: 70,
                                          // color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              myState['deceased'].toString(),
                                              style: TextStyle(fontSize: 11.5),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          : Center(
              child: Container(
                // height: 100,
                // width: 100,
                child: Lottie.asset(
                  "assets/animations/loading1.json",
                ),
              ),
            ),
    );
  }

  Widget stats(String heading1, String heading2, String data1, String data2,
      String data3, String data4, bool bracket1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350],
                offset: Offset(3.0, 3.0),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  heading1 + ":",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      data1,
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    ),
                  ),
                  bracket1
                      ? Container(
                          child: Text(" (" + data2 + ")"),
                        )
                      : Offstage()
                ],
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350],
                offset: Offset(3.0, 3.0),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  heading2 + ":",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      data3,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(" (" + data4 + ")"),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
