import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _News();
  }
}

class _News extends State {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isWindows) {
      WebView.platform = SurfaceAndroidWebView();
    }

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getStats();
    });
  }

  var articles;
  var data;
  var general;
  var news;
  getStats() {
    String url =
        "https://newsapi.org/v2/everything?q=morocco&apiKey=5973a037460a4a7f8a4c47c1c35f544c";
    http.get(Uri.parse(url)).then((response) {
      setState(() {
        news = json.decode(response.body);
      });
    }).catchError((onError) {
      print("Error while calling the api ==> " + onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Morocco news"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: (news == null) || (news["articles"] == null)
                ? 0
                : news["articles"].length,
            itemBuilder: (context, index) {
              String imageURL =
                  news["articles"][index]["urlToImage"].toString();
              String title = news["articles"][index]["title"].toString();
              String url = news["articles"][index]["url"].toString();
              return GestureDetector(
                //onTap: () async => await launch(url),
                onTap: (() => WebView(initialUrl: url)),
                child: Card(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageURL.isNotEmpty
                                ? FadeInImage.assetNetwork(
                                        placeholder:
                                            "images/Blocks-1s-200px.gif",
                                        image: imageURL)
                                    .image
                                : Image.asset("images/Blocks-1s-200px.gif")
                                    .image)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              color: Colors.amber,
                              child: Text(title,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ))),
                        ]),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
