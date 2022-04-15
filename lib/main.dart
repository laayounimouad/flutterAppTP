import 'package:flutter/material.dart';
import 'package:tpflutter1/pages/contacts.dart';
import 'package:tpflutter1/pages/covid19.dart';
import 'package:tpflutter1/pages/github_users.dart';
import 'package:tpflutter1/pages/home.dart';

void main(){
runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: TextTheme(
          //bodyText1: TextStyle(color: Colors.grey)
        )
      ),
      routes: {
        "/":(context)=>Home(),
        "/contacts":(context)=>Contacts(),
        "/github_users":(context)=>GitHubUsers(),
        "/covid_19":(context)=>Covid19()
      },

    );
  }

}