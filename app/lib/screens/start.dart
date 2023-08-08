import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatelessWidget{
  const StartScreen({required this.onSwitchScreen, super.key});
  final void Function(int page) onSwitchScreen; 
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/quiz.png',
        fit: BoxFit.cover,
        width: 300,
        ),
        const SizedBox(height: 20,),
        Text('Countries quiz app', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10,),
        OutlinedButton.icon(
          icon: const Icon(Icons.start),
          onPressed: (){
            onSwitchScreen(2);
          }, 
          label: const Text('Start'),
        ),
        const SizedBox(height: 10,),
        OutlinedButton.icon(
          icon: const Icon(Icons.exit_to_app),
          onPressed: (){
            SystemNavigator.pop();
          }, 
          label: const Text('Exit')
        ),
      ],
    );
  }
}