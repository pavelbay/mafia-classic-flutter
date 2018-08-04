import 'package:flutter/material.dart';
import 'dart:developer';
import 'main.dart';

const SCREEN_NAME_NUMBERS = 'ScreenNamesNumbers';
const SCREEN_NAME_ROLES = 'ScreenNamesRoles';
const LIST_SIZE = 10;

class SelectCardsScreen extends StatefulWidget {
  final screenName;
  final screenNameKey;

  SelectCardsScreen(String screenNameKey, {Key key})
      : screenName = screenNameKey == SCREEN_NAME_ROLES
            ? 'Раздача ролей'
            : 'Раздача номерков',
      this.screenNameKey = screenNameKey;

  @override
  State createState() => SelectCardsState(selectCardFactory(this.screenNameKey));
}

class SelectCardsState extends State<SelectCardsScreen> {
  SelectCard _selectCard;

  SelectCardsState(SelectCard selectCard) {
    _selectCard = selectCard;
    _selectCard.fillList();
  }

  var _currentCardNumber = 0;
  var _shouldFrontBeNext = false;
  var _scaffoldContext;

  void _restart() {
    setState(() {
      _currentCardNumber = 0;
      _shouldFrontBeNext = false;
      _selectCard.fillList();
    });
  }

  void _onImageClick() {
    _shouldFrontBeNext = !_shouldFrontBeNext;
    if (_currentCardNumber < LIST_SIZE || !_shouldFrontBeNext) {
      setState(() {});
    }
  }

  String _getImagePath() {
    var imagePath;
    debugPrint('CurrentCardNumber: $_currentCardNumber');
    if (_shouldFrontBeNext) {
      imagePath = _selectCard.getImagePath(_currentCardNumber);
      _currentCardNumber++;
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
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _restart();
                final snackBar =
                    SnackBar(content: Text('Новая раздача началась'));
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

abstract class SelectCard {
  void fillList();

  String getImagePath(int cardNumber);
}

class SelectNumberCard implements SelectCard {
  final _numbers = List();

  @override
  void fillList() {
    _numbers.clear();

    for (var i = 1; i <= LIST_SIZE; i++) {
      _numbers.add(i);
    }

    _numbers.shuffle();
  }

  @override
  String getImagePath(int cardNumber) {
    var imagePath;
    final number = _numbers[cardNumber];
    final basePath = 'graphics/numbers';
    switch (number) {
      case 1:
        imagePath = 'graphics/ic_1.png';
        break;

      case 2:
        imagePath = 'graphics/ic_2.png';
        break;

      case 3:
        imagePath = 'graphics/ic_3.png';
        break;

      case 4:
        imagePath = 'graphics/ic_4.png';
        break;

      case 5:
        imagePath = 'graphics/ic_5.png';
        break;

      case 6:
        imagePath = 'graphics/ic_6.png';
        break;

      case 7:
        imagePath = 'graphics/ic_7.png';
        break;

      case 8:
        imagePath = 'graphics/ic_8.png';
        break;

      case 9:
        imagePath = 'graphics/ic_9.png';
        break;

      case 10:
        imagePath = 'graphics/ic_10.png';
        break;
    }

    return imagePath;
  }
}

class SelectRoleCard implements SelectCard {
  final _roles = List();

  @override
  void fillList() {
    _roles.clear();

    for (var i = 0; i < 6; i++) {
      _roles.add(GameRole.CITIZEN);
    }

    for (var i = 0; i < 2; i++) {
      _roles.add(GameRole.MAFIA);
    }

    _roles.add(GameRole.SHERIFF);
    _roles.add(GameRole.DON);
    _roles.shuffle();
  }

  @override
  String getImagePath(int cardNumber) {
    var imagePath;
    final basePath = 'graphics/roles';
    final role = _roles[cardNumber];

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

    return imagePath;
  }
}

SelectCard selectCardFactory(String screenName) {
  switch (screenName) {
    case SCREEN_NAME_ROLES:
      return SelectRoleCard();
    case SCREEN_NAME_NUMBERS:
      return SelectNumberCard();
  }

  return SelectRoleCard();
}
