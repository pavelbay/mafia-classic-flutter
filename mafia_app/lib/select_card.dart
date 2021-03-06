import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';

const SCREEN_NAME_NUMBERS = 'ScreenNamesNumbers';
const SCREEN_NAME_ROLES = 'ScreenNamesRoles';
const LIST_SIZE = 10;
const IMAGE_ASSET_PATH = 'graphics';

class SelectCardsScreen extends StatefulWidget {
  final screenName;
  final screenNameKey;

  SelectCardsScreen(String screenNameKey, {Key key})
      : screenName = screenNameKey == SCREEN_NAME_ROLES
            ? 'Раздача ролей'
            : 'Раздача номерков',
        this.screenNameKey = screenNameKey;

  @override
  State createState() =>
      SelectCardsState(selectCardFactory(this.screenNameKey));
}

class SelectCardsState extends State<SelectCardsScreen> {
  SelectCard _selectCard;

  SelectCardsState(SelectCard selectCard) {
    _selectCard = selectCard;
    _selectCard.fillList();
  }

  static const DEFAULT_IMAGE_PATH = '$IMAGE_ASSET_PATH/ic_back.png';

  var _currentCardNumber = 0;
  var _shouldFrontBeNext = false;
  var _scaffoldContext;
  var _imagePath = DEFAULT_IMAGE_PATH;

  void _restart() {
    setState(() {
      _currentCardNumber = 0;
      _shouldFrontBeNext = false;
      _imagePath = DEFAULT_IMAGE_PATH;
      _selectCard.fillList();
    });
  }

  void _onImageClick() {
    if (_currentCardNumber < LIST_SIZE || _shouldFrontBeNext) {
      setState(() {
        _shouldFrontBeNext = !_shouldFrontBeNext;
        _imagePath = _getImagePath();
      });
    }
  }

  String _getImagePath() {
    var imagePath;
    debugPrint('CurrentCardNumber: $_currentCardNumber');
    if (_shouldFrontBeNext) {
      imagePath = _selectCard.getImagePath(_currentCardNumber);
      _currentCardNumber++;
    } else {
      imagePath = DEFAULT_IMAGE_PATH;
    }

    return imagePath;
  }

  Widget _buildThumbnails() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          if (i < LIST_SIZE) {
            return _buildColumn(i);
          }
        });
  }

  Widget _buildColumn(int index) {
    return Container(
      child: new IconTheme(
        data: new IconThemeData(color: Colors.white),
        child: _buildIcon(index),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (_currentCardNumber > index) {
      return Icon(Icons.clear);
    } else {
      return Icon(Icons.add);
    }
  }

  Widget _buildBody() {
    final image = Image.asset(
        _imagePath,
        fit: BoxFit.cover,
        gaplessPlayback: true
    );
    return GestureDetector(
      onTap: _onImageClick,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: image,
          ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              height: 40.0,
              width: 250.0,
              child: _buildThumbnails(),
            ),
          ),
        ],
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
    final basePath = '$IMAGE_ASSET_PATH/numbers';
    switch (number) {
      case 1:
        imagePath = '$IMAGE_ASSET_PATH/ic_1.png';
        break;

      case 2:
        imagePath = '$IMAGE_ASSET_PATH/ic_2.png';
        break;

      case 3:
        imagePath = '$IMAGE_ASSET_PATH/ic_3.png';
        break;

      case 4:
        imagePath = '$IMAGE_ASSET_PATH/ic_4.png';
        break;

      case 5:
        imagePath = '$IMAGE_ASSET_PATH/ic_5.png';
        break;

      case 6:
        imagePath = '$IMAGE_ASSET_PATH/ic_6.png';
        break;

      case 7:
        imagePath = '$IMAGE_ASSET_PATH/ic_7.png';
        break;

      case 8:
        imagePath = '$IMAGE_ASSET_PATH/ic_8.png';
        break;

      case 9:
        imagePath = '$IMAGE_ASSET_PATH/ic_9.png';
        break;

      case 10:
        imagePath = '$IMAGE_ASSET_PATH/ic_10.png';
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
    final basePath = '$IMAGE_ASSET_PATH/roles';
    final role = _roles[cardNumber];

    switch (role) {
      case GameRole.CITIZEN:
        imagePath = '$IMAGE_ASSET_PATH/ic_citizen.png';
        break;

      case GameRole.MAFIA:
        imagePath = '$IMAGE_ASSET_PATH/ic_maf.png';
        break;

      case GameRole.DON:
        imagePath = '$IMAGE_ASSET_PATH/ic_don.png';
        break;

      case GameRole.SHERIFF:
        imagePath = '$IMAGE_ASSET_PATH/ic_sheriff.png';
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
