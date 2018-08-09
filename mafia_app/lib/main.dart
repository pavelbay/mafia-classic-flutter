import 'package:flutter/material.dart';

import 'select_card.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Игра мафия'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  static const double margins = 6.0;

  void _navigateToSelectCards(BuildContext context, String screenName) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SelectCardsScreen(screenName))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(margins),
              child: RaisedButton (
                child: const Text('Начать раздачу ролей'),
                onPressed: (){_navigateToSelectCards(context, SCREEN_NAME_ROLES);}
              ),
            ),
            Container(
              margin: const EdgeInsets.all(margins),
              child: RaisedButton (
                child: const Text('Начать раздачу номерков'),
                onPressed: () {_navigateToSelectCards(context, SCREEN_NAME_NUMBERS);},
              ),
            ),
            Container(
              margin: const EdgeInsets.all(margins),
              child: RaisedButton (
                child: const Text('Начать новую игру'),
                onPressed: () { }// TODO: implement this
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum GameRole { CITIZEN, MAFIA, DON, SHERIFF }
