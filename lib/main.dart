import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return sharepreference();
  }
}

class sharepreference extends State<MyHomePage> {
  var controller_key = TextEditingController();
  var controller_data = TextEditingController();

  String text_to_show = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share Preference")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controller_key,
            decoration: InputDecoration(hintText: "Enter Key"),
          ),
          TextField(
            controller: controller_data,
            decoration: InputDecoration(hintText: "Enter data"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text("save"),
                  onPressed:(){
                      saveData(controller_key.text, controller_data.text);}
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text("read data"),
                  onPressed: (){readData(controller_key.text);},
                ),
              )
            ],
          ),
           Text("$text_to_show")
          ],
      ),
    );
  }

  saveData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  Future<String> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.getString(key);
    setState(() {
      text_to_show = prefs.getString(key);
      return text_to_show;
    });
  }
}
