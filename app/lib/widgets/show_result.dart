import 'package:flutter/material.dart';

class ShowResult extends StatelessWidget{
  const ShowResult({required this.onSwitchScreen, required this.point, required this.maximumQuestion, super.key});
  final int point;
  final int maximumQuestion;
  final void Function(int page) onSwitchScreen; 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Game over!', style: Theme.of(context).textTheme.titleLarge,),
        const SizedBox(height: 10,),
        Text('Your score: $point out of $maximumQuestion', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
        const SizedBox(height: 10,),
        OutlinedButton.icon(
          icon: const Icon(Icons.home),
          onPressed: (){
            onSwitchScreen(1);
          }, 
          label: const Text('Home'),
        ),
      ]
    );
  }
  
}