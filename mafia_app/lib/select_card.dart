import 'package:flutter/material.dart';

const SCREEN_NAME_NUMBERS = 'ScreenNamesNumbers';
const SCREEN_NAME_ROLES = 'ScreenNamesRoles';

class SelectCardsScreen extends StatefulWidget {
  final String screenName;

  SelectCardsScreen({Key key, this.screenName});

  @override
  State createState() => SelectCardsState();
}

class SelectCardsState extends State<SelectCardsScreen> {
  void _restart() {}

  void _onImageClick() {}

  Widget _buildBody() {
    return GestureDetector(
      onTap: _onImageClick,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('graphics/ic_back.png'),
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
          IconButton(icon: Icon(Icons.refresh), onPressed: _restart)
        ],
      ),
      body: _buildBody(),
    );
  }
}
