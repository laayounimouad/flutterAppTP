import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Covid19 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Covid19();
  }
}

class _Covid19 extends State<Covid19> {
  var stats;
  var data;
  var general;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getStats();
    });
  }

  getStats() {
    String url = "https://api.covid19api.com/summary";
    http.get(Uri.parse(url)).then((response) {
      setState(() {
        Map _json = json.decode(response.body);
        data = [];
        _json.values.forEach((element) {
          if (element != null) {
            //print("$element \n\n");
            data.add(element);
          }
        });
        //searchCountry(keyword);
      });
      general = [];
      stats = [];
      general.add(data[2]);
      stats.add(data[3]);
//print(data);
    }).catchError((onError) {
      print("Error while calling the api ==> " + onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    //getStats();
    return Scaffold(
      appBar: AppBar(
        title: Text('covid 19 stats'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                color: Colors.cyan[100],
                child: ListTile(
                    title: Title(
                      color: Colors.black,
                      child: Text("World Stats"),
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                            "Total confirmed : ${general[0]["TotalConfirmed"].toString()}"),
                        Text(
                            "Total deaths : ${general[0]["TotalDeaths"].toString()}"),
                      ],
                    )),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: stats == null ? 0 : stats[0].length,
                itemBuilder: (context, index) {
                  var country = stats[0][index]["Country"];
                  var totalConfirmed = stats[0][index]["TotalConfirmed"];
                  var totalDeaths = stats[0][index]["TotalDeaths"];
                  return Card(
                    child: ListTile(
                      title: Title(
                          color: Colors.black,
                          child: Text("Country : $country")),
                      subtitle: Column(
                        children: [
                          Text("TotalConfirmed :$totalConfirmed"),
                          Text("TotalDeaths :$totalDeaths",
                              style: TextStyle(color: Colors.red[400])),
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          )),
    );
  }
}
