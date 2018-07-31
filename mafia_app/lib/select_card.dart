import 'package:flutter/material.dart';
import 'main.dart';


const SCREEN_NAME_NUMBERS = 'ScreenNamesNumbers';
const SCREEN_NAME_ROLES = 'ScreenNamesRoles';

class SelectCardsScreen extends StatefulWidget {
  final String screenName;

  SelectCardsScreen({Key key, this.screenName});

  @override
  State createState() => SelectCardsState();
}

class SelectCardsState extends State<SelectCardsScreen> {

  SelectCardsState() {
    _fillList();
  }

  static const listSize = 10;

  final _roles = List();
  var _currentCardNumber = 0;
  var _shouldFrontBeNext = false;
  var _scaffoldContext;

  void _restart() {
    setState(() {
      _currentCardNumber = 0;
      _shouldFrontBeNext = false;
      _roles.clear();
      _fillList();
    });
  }

  void _onImageClick() {
    _shouldFrontBeNext = !_shouldFrontBeNext && _currentCardNumber < listSize - 1;

    setState(() {
      if (_shouldFrontBeNext) {
        _currentCardNumber++;
      }
    });

  }

  void _fillList() {
    for (var i = 0; i < 6; i++) {
      _roles.add(GameRole.CITIZEN);
    }

    for (var i = 0; i < 3; i++) {
      _roles.add(GameRole.MAFIA);
    }

    _roles.add(GameRole.SHERIFF);
    _roles.add(GameRole.DON);
    _roles.shuffle();
  }

  String _getImagePath() {
    var imagePath;
    if (_shouldFrontBeNext) {
      final role = _roles[_currentCardNumber];

      switch (role) {
        case GameRole.CITIZEN:
          imagePath = 'graphics/ic_citizen.png';
          break;

        case GameRole.MAFIA:
          imagePath = 'graphics/ic_maf.png';
          break;

        case GameRole.DON:
          imagePath = 'graphics/ic_don.png';
          break;

        case GameRole.SHERIFF:
          imagePath = 'graphics/ic_sheriff.png';
          break;
      }
    } else {
      imagePath = 'graphics/ic_back.png';
    }

    return imagePath;
  }

  Widget _buildBody() {
    final imagePath = _getImagePath();

    return GestureDetector(
      onTap: _onImageClick,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenName),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed:() {
            _restart();
            final snackBar = SnackBar(content: Text('Новая раздача началась'));
            Scaffold.of(_scaffoldContext).showSnackBar(snackBar);
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        _scaffoldContext = context;
        return _buildBody();
      }),
    );
  }
}
