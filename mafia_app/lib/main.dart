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

class MyRoute<T> extends MaterialPageRoute<T> {
  MyRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
      if (settings.isInitialRoute)
        return child;
      final anim = Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero
      ).animate(animation);
      return SlideTransition(position: anim, child: child);
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  static const double margins = 6.0;

  void _navigateToSelectCards(BuildContext context, String screenName) {
    Navigator.of(context).push(
        MyRoute(builder: (context) => SelectCardsScreen(screenName))
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
