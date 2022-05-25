import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:quiz/model/get_questions.dart';
import 'package:quiz/helper/helper.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:quiz/pages/dashboard.dart';
class DiagnosticTest extends StatefulWidget {
  const DiagnosticTest({Key? key}) : super(key: key);

  @override
  State<DiagnosticTest> createState() => _DiagnosticTestState();
}

class _DiagnosticTestState extends State<DiagnosticTest> {
  int _currentPage = 0;
  int _currentSlide = 0;
  List<Widget> slides = [];
  int questionIndex = 0;
  int counting = 6;
  bool progressCode = true;
  String errorMessage = "Fetching Questions";
  String ready = "Waiting";
  CountdownTimerController? controller;
  int endTime = 0;
  List<T> map<T>(int listLength, Function handler) {
    List list = [];
    for (var i = 0; i < listLength; i++) {
      list.add(i);
    }
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  Map<String, Widget> getPage() {
    switch (_currentPage) {
      case 0:
        return {'Text Question': testQuestion()};
      case 1:
        return {'Image Question': imageQuestion()};

    }
    return {'': Container()};
  }

  set(String text){
    String htmlData = """$text""";
    dom.Document document = htmlparser.parse(htmlData);
    /// sanitize or query document here
    Widget html = Html(
      data: htmlData,
    );

    return html;
  }
  getQuestions()async{
    try{
      var js = await doGet('questions/get?level_id=1&course_id=2&limit=20');
      print("res comments: $js");
      if(js["status"] && js["data"].isNotEmpty){
        for(int i = 0; i < js["data"].length; i++){
          QuestionsResponse dataData = QuestionsResponse.fromJson(js["data"][i]);
          listQuestionsResponse.add(dataData);
        }
      }else{
        errorMessage = "No Questions Available";
      }
      if(mounted){
        setState(() {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 1200;
          controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
          progressCode = false;
        });
      }

    }catch(e){
      if(mounted){
        setState(() {
          progressCode = false;
        });
      }
      errorMessage = e.toString();
      print("error subscriptions: $e");
    }

  }

  markAnswer({int position = 0})async{
   setState(() {
     for(int t = 0; t < listQuestionsResponse[questionIndex].answers!.length; t++){
       listQuestionsResponse[questionIndex].answers![t].answered = 0;
       listQuestionsResponse[questionIndex].correct = 0;
       listQuestionsResponse[questionIndex].skipped = 0;
     }
     final   QuestionsResponse qts = listQuestionsResponse[questionIndex];
     qts.answers![position].answered = 1;
     if(listQuestionsResponse[questionIndex].answers![position].value == 1){
       qts.correct = 1;
     }
     listQuestionsResponse[questionIndex] = qts;
   });
  }



  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
     timeSpent = null;
    remainingTime = null;
     listQuestionsResponse.clear();
    getQuestions();

  }

  void onEnd() {
    print('onEnd');
    showDialogOk(message: "Time is up, kindly click on ok to view your scores",context: context,target: Dashboard(),status: true,replace: true,dismiss: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: solonGray700,
        appBar: AppBar(
          title:     Container(
            width: appWidth(context),
            child: Row(
             children: [
               Container(
                 child: sText("Question Number",color: Colors.white,size: 20,weight: FontWeight.bold),
               ),
               SizedBox(width: 10,),
               Container(
                 padding: appPadding(5),
                 child: Center(child: sText("${listQuestionsResponse.isNotEmpty ? questionIndex + 1 : 0}",color: Colors.white,weight: FontWeight.bold)),
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   border: Border.all(color: Colors.white,width: 2)
                 ),
               )
             ],
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.green,
          actions: [
            GestureDetector(
              onTap: (){
                goTo(context, DiagnosticTest(),replace: true);
              },
              child: Container(
                margin: leftPadding(10),
                child: CountdownTimer(
                  endTime: endTime,
                  controller: controller,
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    if(time != null){
                      remainingTime = time;
                      var dateFormat = DateFormat('h:m:s');
                      DateTime durationStart = dateFormat.parse('10:20:00');
                      DateTime durationEnd = dateFormat.parse('10:${remainingTime!.min == null ? "00" : remainingTime!.min}:${remainingTime!.sec}');

                      print('durationStart: $durationStart');
                      print('durationEnd: $durationEnd');

                      timeSpent = durationEnd.difference(durationStart);

                      print('difference: ${timeSpent.toString().substring(2,8).toString().split(".").first} hours');
                    }
                    // print(remainingTime!.sec);
                    if(controller != null){
                      if(!controller!.isRunning){
                        ready = "Game Over";
                      }
                    }
                    if (time == null) {
                      return sText("$ready",color: Colors.green,weight: FontWeight.bold);
                    }
                    return sText('${time.min == null ? "00" : time.min}:${time.sec}',color: Colors.green);
                  },
                ),
                padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft:  Radius.circular(30))
                ),
              ),
            )
          ],
        ),
        body: getPage().values.first);
  }


  Widget testQuestion() {
    return Column(
      children: [
        listQuestionsResponse.isNotEmpty ?
        Expanded(
          child: ListView(
            children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                     width: appWidth(context),
                     child: sText("${listQuestionsResponse[questionIndex].text}",color: Colors.white,weight: FontWeight.bold,size: 20,align: TextAlign.center),
                     color: appMainDarkGrey
                   ),
                   Container(
                       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                       width: appWidth(context),
                       child: sText("Choose the right answer to the question above",color: Colors.white,weight: FontWeight.normal,size: 12,align: TextAlign.center),
                       color: Colors.blueGrey
                   ),
                   listQuestionsResponse[questionIndex].instructions!.isNotEmpty ?
                   Container(
                     width: appWidth(context),
                     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                     color: appMainDarkGrey,
                     child: Column(
                       children: [
                         listQuestionsResponse[questionIndex].topic != null ?
                         Container(
                             child: sText("${listQuestionsResponse[questionIndex].topic!.name}",color: Colors.white,weight: FontWeight.bold),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.white)
                                )
                              ),
                         ) : Container(),
                         SizedBox(height: 20,),
                         Container(
                             child: sText("${ listQuestionsResponse[questionIndex].instructions!}",color: Colors.white,weight: FontWeight.normal,size: 12,align: TextAlign.center),
                         ),
                       ],
                     ),
                   ) : Container(),
                   SizedBox(height: 10,),
                   for(int i = 0; i < listQuestionsResponse[questionIndex].answers!.length; i++)
                     GestureDetector(
                       onTap: ()async{
                           if(questionIndex == 19){
                             await markAnswer(position: i);
                             showDialogOk(message: "You've finished answering the questions, click on ok to view your scores",context: context,target: Dashboard(),status: true,replace: true,dismiss: false);
                           }else{
                             await markAnswer(position: i);
                             questionIndex++;
                           }
                       },
                       child: Container(
                         width: appWidth(context),
                         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                         child: sText("${listQuestionsResponse[questionIndex].answers![i].text}",color: listQuestionsResponse[questionIndex].answers![i].answered == 1 ? Colors.white : Colors.grey[400]!,align: TextAlign.center,weight: FontWeight.bold),
                         decoration: BoxDecoration(
                           color: listQuestionsResponse[questionIndex].answers![i].answered == 1 ? Colors.black26 : solonGray700,
                           border: Border.all(color: listQuestionsResponse[questionIndex].answers![i].answered == 1 ? Colors.deepPurpleAccent : solonGray700)
                         ),
                       ),
                     )
                 ],
               )
            ],
          ),
        ) : progressCode ?
        Expanded(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            progress(),
            SizedBox(height: 10,),
            sText("$errorMessage",color: Colors.white)
          ],
        ),)) :
        Expanded(child: Center(child: sText("$errorMessage",color: Colors.white),)),
        listQuestionsResponse.isNotEmpty ?
        Container(
            padding: appPadding(20),
            child:      Row(
              children: [
                Expanded(
                  child: solonOutlineButton(
                      content: sText('Previous', color: Colors.white, weight: FontWeight.bold),
                      height: 50,
                      backgroundColor: Colors.green,
                      shadowStrength: 0,
                      onPressed: () async{
                      setState(() {
                        if(questionIndex == 0){
                          toast("Do you want to quit the questions");
                        }else{
                          questionIndex--;
                        }
                      });
                      }),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: solonOutlineButton(
                    shadowStrength: 0,
                      content: sText('Next', color: Colors.white, weight: FontWeight.bold),
                      height: 50,
                      backgroundColor: Colors.green,
                      onPressed: () async{
                        setState(() {
                          if(questionIndex == 19){
                            // toast("Done exiting now");
                            showDialogOk(message: "You've finished answering the questions, click on ok to view your scores",context: context,target: Dashboard(),status: true,replace: true,dismiss: false);
                          }else{
                            questionIndex++;
                          }
                        });
                      }),
                ),
              ],
            )
        ) : Container()
      ],
    );
  }
  Widget imageQuestion() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                      width: appWidth(context),
                      child: sText("Which of the following is a bread of rabbit?",color: Colors.white,weight: FontWeight.bold),
                      color: appMainDarkGrey
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      width: appWidth(context),
                      child: sText("Choose the right answer to the question above",color: Colors.white,weight: FontWeight.normal,size: 12,align: TextAlign.center),
                      color: Colors.blueGrey
                  ),
                  Container(
                    width: appWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    color: appMainDarkGrey,
                    child: Column(
                      children: [
                        Container(
                          child: sText("Which of the following is a bread of rabbit?",color: Colors.white,weight: FontWeight.bold),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white)
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: displayImage("https://media.istockphoto.com/photos/abstract-graphic-world-map-illustration-on-blue-background-big-data-picture-id1294021851",radius: 0,height: 150),
                        ),
                      ],




                    ),
                  ),
                  for(int i = 0; i < 4; i++)
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: sText("Sokoto Sokoto Sokoto Sokoto Sokoto",color: Colors.grey[400]!,align: TextAlign.center,weight: FontWeight.bold),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurpleAccent)
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),

        Container(
            padding: appPadding(20),
            child:      Row(
              children: [
                Expanded(
                  child: solonOutlineButton(
                      content: sText('Previous', color: Colors.white, weight: FontWeight.bold),
                      height: 50,
                      backgroundColor: Colors.green,
                      shadowStrength: 0,
                      onPressed: () async{
                      }),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: solonOutlineButton(
                      shadowStrength: 0,
                      content: sText('Next', color: Colors.white, weight: FontWeight.bold),
                      height: 50,
                      backgroundColor: Colors.green,
                      onPressed: () async{

                      }),
                ),
              ],
            )
        )
      ],
    );
  }
}

