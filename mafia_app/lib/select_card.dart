import 'package:flutter/material.dart';

import 'main.dart';

const SCREEN_NAME_NUMBERS = 'ScreenNamesNumbers';
const SCREEN_NAME_ROLES = 'ScreenNamesRoles';

class SelectCardsScreen extends StatefulWidget {
  final String screenName;

  SelectCardsScreen({Key key, this.screenName});

  @override
  State createState() => SelectCardsState(selectCardFactory(this.screenName));
}

class SelectCardsState extends State<SelectCardsScreen> {
  SelectCard _selectCard;

  SelectCardsState(SelectCard selectCard) {
    _selectCard = selectCard;
    _selectCard.fillList();
  }

  static const listSize = 10;

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
    _shouldFrontBeNext =
        !_shouldFrontBeNext && _currentCardNumber < listSize - 1;

    setState(() {
      if (_shouldFrontBeNext) {
        _currentCardNumber++;
      }
    });
  }

  String _getImagePath() {
    var imagePath;
    if (_shouldFrontBeNext) {
      imagePath = _selectCard.getImagePath(_currentCardNumber);
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

    for (var i = 1; i<=10; i++) {
      _numbers[i] = i;
    }

    _numbers.shuffle();
  }

  @override
  String getImagePath(int cardNumber) {
    return null;
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

    for (var i = 0; i < 3; i++) {
      _roles.add(GameRole.MAFIA);
    }

    _roles.add(GameRole.SHERIFF);
    _roles.add(GameRole.DON);
    _roles.shuffle();
  }

  @override
  String getImagePath(int cardNumber) {
    var imagePath;
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
