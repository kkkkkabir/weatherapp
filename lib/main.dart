// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  bool hasData = false;
  Future getWeather() async {
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Pune&units=metric&appid=5a43765bd638623dca26642fffa81d6a"));
    var results = jsonDecode(response.body);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windSpeed = results['wind']['speed'];
      hasData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: hasData == true
            ? Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Currently in India",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
                        ),
                        Text(
                          "${temp.toString()}\u00B0",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            currently.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Card(
                            elevation: 2.0,
                            child: ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.thermometerHalf,
                                color: Colors.red[300],
                              ),
                              title: Text(
                                "Temperature",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red[300],
                                ),
                              ),
                              trailing: Text(
                                "${temp.toString()}\u00B0",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 2.0,
                            child: ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.cloud,
                                color: Colors.blue[500],
                              ),
                              title: Text(
                                "Weather",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blue[500]),
                              ),
                              trailing: Text(
                                description.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 2.0,
                            child: ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.sun,
                                color: Colors.orange[600],
                              ),
                              title: Text(
                                "Humidity",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange[600]),
                              ),
                              trailing: Text(
                                humidity.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 2.0,
                            child: ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.wind,
                                color: Colors.blueGrey[400],
                              ),
                              title: Text(
                                "Wind Speed",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueGrey[400]),
                              ),
                              trailing: Text(
                                windSpeed.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}
