import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{
  const AnswerButton({required this.isCorrect, required this.isWrong, required this.answerText, required this.onTap, super.key});
  final String answerText;
  final void Function(String answer) onTap;
  final bool isCorrect;
  final bool isWrong;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor=Colors.white;
    Color foregroundColor= Theme.of(context).textTheme.labelLarge!.color!;
    if(isCorrect){
      backgroundColor=Colors.green;
      foregroundColor=Colors.white;
    }
    if(isWrong){
      backgroundColor=Colors.red;
      foregroundColor=Colors.white;
    }

    return ElevatedButton(
      onPressed: (){
        onTap(answerText);
      }, 
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
    ),
    child: Text(answerText, textAlign: TextAlign.center,),
    );
  }
}