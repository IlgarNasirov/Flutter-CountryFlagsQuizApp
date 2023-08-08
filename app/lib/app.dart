import 'package:flutter/material.dart';

import 'package:app/widgets/questions.dart';
import 'package:app/widgets/show_result.dart';
import 'package:app/screens/start.dart';

class App extends StatefulWidget{
  const App({super.key});
  @override
  State<App> createState()=>_AppState();
}

class _AppState extends State<App>{
  var _currentPage = 1;
  int? _point;
  int? _maximumQuestion;

  void _switchScreen(int page){
    setState(() {
      _currentPage=page;
    });
  }

  void _showResult(int point, int maximumQuestion){
    setState(() {
      _currentPage=3;
      _point=point;
      _maximumQuestion=maximumQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget=StartScreen(onSwitchScreen: _switchScreen);
    if(_currentPage==2){
      widget= Questions(onSwitchScreen: _switchScreen, onShowResult: _showResult,);
    }
    else
    if(_currentPage==3){
      widget=ShowResult(point: _point!, maximumQuestion: _maximumQuestion!, onSwitchScreen: _switchScreen,);
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor:const Color.fromARGB(255, 245, 245, 245),
        body: Center(
          child: widget,
        ),
      ),
    );
  }
}