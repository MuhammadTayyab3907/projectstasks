/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SecondRoute.dart';

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
           Text("$text_to_show"),
          Padding(
            padding: EdgeInsets.only(top:58.0),
            child: RaisedButton(
              child: Text("Go to second Route"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
          )
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
}*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(
      todos: List.generate(
        20,
        (i) => Todo(
          'Todo $i',
          'A description of what needs to be done for Todo $i',
        ),
      ),
    ),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: todos[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
