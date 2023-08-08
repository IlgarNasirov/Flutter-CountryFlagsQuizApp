import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app/app.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp
  ]).then((fn){
  runApp(const App());
  });
}