import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:app/models/country_question.dart';
import 'package:app/widgets/answer_button.dart';
import 'package:app/constant.dart';

class Questions extends StatefulWidget{
  const Questions({required this.onSwitchScreen, required this.onShowResult, super.key});
  final void Function(int page) onSwitchScreen; 
  final void Function(int point, int maximumQuestion) onShowResult;

  @override
  State<Questions> createState()=>_QuestionsState();
}

class _QuestionsState extends State<Questions>{
  late CountryQuestion _countryQuestion;
  var _selectedAnswer='';
  final _maximumQuestion=10;
  var _currentQuestion=1;
  var _point=0;
  var _isLoading=true;
  var _error='';

  void _loadQuestion() async{
   final url=Uri.http(Constant.url, 'v1/countries'); 
    try{
    final response=await http.get(url);
    final Map<String, dynamic> data=json.decode(response.body);
    final List<String>answers=[];
    for (var element in data['answers']) {
      answers.add(element);
    }
    _countryQuestion=CountryQuestion(question: data['question'], answers: answers, correctAnswer: data['correctAnswer']);
          setState(() {
          _selectedAnswer='';
          _isLoading=false;
    });
    }
    catch(error){
      setState(() {
        _isLoading=false;
        _error='Something went wrong!';
      });
    }
  }
  
  void _chooseAnswer(String answer)async{
    setState(() {
      _selectedAnswer=answer;
    });
    await Future.delayed(const Duration(seconds: 2));
    _currentQuestion++;
    if(_currentQuestion>_maximumQuestion){
      widget.onShowResult(_point, _maximumQuestion);
    }
    setState(() {
      _isLoading=true;
    });
    _loadQuestion();
  }

  void _tempFunction(String temp)=>{};

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }
  
  @override
  Widget build(BuildContext context) {
    Widget content=const CircularProgressIndicator();
    
    if(!_isLoading){
      if(_error.isNotEmpty){
        content=Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error, style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 20,),
                    OutlinedButton.icon(
          icon: const Icon(Icons.home),
          onPressed: (){
            widget.onSwitchScreen(1);
          }, 
          label: const Text('Home'),
        ),
        ],
        );
      }
      else{
        content=Container(
          margin: const EdgeInsets.all(25),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Score: $_point', style: Theme.of(context).textTheme.titleMedium,),
              Text('$_currentQuestion/$_maximumQuestion', style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
          const SizedBox(height:15),
          Image.network(
            _countryQuestion.question,
            loadingBuilder: (context, child, loadingProgress){
              if(loadingProgress!=null){
                return const CircularProgressIndicator();
              }
              return child;
            } ,
            fit: BoxFit.cover,
            width: 300,
          ),
          const SizedBox(height: 20,),
          Text('Guess the country', style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 20,),
          ..._countryQuestion.answers.map((item){
            if(_selectedAnswer.isEmpty){
              return AnswerButton(answerText: item, onTap: _chooseAnswer, isCorrect: false, isWrong: false,);
            }
            else
            if(item==_countryQuestion.correctAnswer){
              if(_selectedAnswer==item){
                _point++;
              }
              return AnswerButton(answerText: item, onTap: _tempFunction, isCorrect: true, isWrong: false, );
            }
            else
            if(_selectedAnswer==item){
              return AnswerButton(answerText: item, onTap: _tempFunction, isCorrect: false, isWrong: true, );
            }  
            else{
              return AnswerButton(answerText: item, onTap: _tempFunction, isCorrect: false, isWrong: false, );
            }
          }),
              ],
            ),
        );
      }
    }

    return content;
  }
}