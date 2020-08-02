import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wall-X'),
        ),
        body: FutureBuilder(
            future: getfulist(),
            builder: (context, sanpshot) {
              if (sanpshot.hasData) {
                return listview(items1: sanpshot.data);
              }
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }

  Future getfulist() async {
    var URL = 'https://api.pexels.com/v1/curated';
    var response = await http.get(URL, headers: {
      "Authorization":
          "Your Access Key for Pexels"
    });
    if (response.statusCode == 200) {
      var jsdata = jsonDecode(response.body);
      //print(jsdata);
      var nexturl = jsdata['next_page'];

      var links = [];
      for (var x in jsdata['photos']) {
        links.add(x['src']['medium']);
      }
      print(links);
      return links;
    } else {
      print("Value Error in Status Code");
    }
  }
}

class listview extends StatelessWidget {
  var items1 = [];

  listview({this.items1});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items1.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == items1.length) {}
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.network(
                    items1[index],
                    width: 100,
                    height: 200,
                    fit: BoxFit.cover,
                  )));
        });
  }

  List<Widget> dispitems() {
    print(items1);
    List<Widget> item = [];
    for (var x in items1) {
      item.add(ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          x,
          height: 150,
          width: 200,
          fit: BoxFit.cover,
        ),
      ));
    }
    return item;
  }
}
