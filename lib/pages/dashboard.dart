import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:quiz/helper/helper.dart';
import 'package:quiz/pages/diagnostic_test.dart';
import 'package:quiz/pages/review/index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool switchOn = false;
  bool isTopic = true;

  getScores(){
    int correctScore = 0;
    double scorePercentage = 0;
    for(int i = 0; i < listQuestionsResponse.length; i++){
      if(listQuestionsResponse[i].correct == 1){
        correctScore++;
      }
    }
    scorePercentage = (correctScore/20) * 100;

    print(scorePercentage);

    return scorePercentage.toStringAsFixed(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: sText("${getScores()}%",color: appMainDarkGrey,weight: FontWeight.bold,size: 25),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: sText("Score"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: sText("${timeSpent.toString().substring(2,8).toString().split(".").first}",color: appMainDarkGrey,weight: FontWeight.bold,size: 25),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: sText("Time taken"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: sText("${listQuestionsResponse.length}",color: appMainDarkGrey,weight: FontWeight.bold,size: 25),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: sText("Questions"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(color: Colors.white,thickness: 2,),
            ),
            SizedBox(height: 20,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isTopic = true;
                      });
                    },
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: sText("Topics",weight: FontWeight.bold,color: isTopic ? Colors.white : Colors.white38,align: TextAlign.center),
                      decoration: BoxDecoration(
                        color: isTopic ? Colors.blue : Colors.lightBlue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:Radius.circular(30) )
                      ),
                    ),
                  ),
                  SizedBox(width: 1,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isTopic = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: sText("Questions",weight: FontWeight.bold,color: !isTopic ? Colors.white : Colors.white38,align: TextAlign.center),
                      decoration: BoxDecoration(
                          color: !isTopic ? Colors.blue : Colors.lightBlue,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight:Radius.circular(30) )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Container(
                    child: Icon(Icons.percent,color: Colors.blue,),
                  ),
                  SizedBox(width: 5,),
                  FlutterSwitch(
                    width: 50.0,
                    height: 20.0,
                    valueFontSize: 10.0,
                    toggleSize: 15.0,
                    value: switchOn,
                    borderRadius: 30.0,
                    padding: 2.0,
                    showOnOff: false,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    inactiveTextColor: Colors.red,
                    inactiveToggleColor: Colors.white,

                    onToggle: (val) {
                      setState(() {
                        switchOn = val;
                      });
                    },
                  ),

                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index){
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: sText("Cells",color: Colors.grey,weight: FontWeight.bold),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: sText("Good performance",color: Colors.grey,size: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: sText("8/10",color: Colors.blue,weight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40,right: 40,bottom: 0,top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      goTo(context, Review());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: sText("Review",color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ),
                    ),
                  ),
                  SizedBox(width: 1,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: sText("Revise",color: Colors.grey),
                    color: Colors.white,
                  ),
                  SizedBox(width: 1,),
                  GestureDetector(
                    onTap: (){
                      showDialogYesNo(message:"Do you want to start a new diagnostic test?",  context: context, target:DiagnosticTest() ,replace: true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: sText("New test",color: Colors.grey),
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))
                      ),

                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
