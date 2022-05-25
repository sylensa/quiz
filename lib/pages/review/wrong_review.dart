import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:quiz/helper/helper.dart';
import 'package:quiz/model/get_questions.dart';

class WrongReview extends StatefulWidget {
  const WrongReview({Key? key}) : super(key: key);

  @override
  State<WrongReview> createState() => _WrongReviewState();
}

class _WrongReviewState extends State<WrongReview> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: appPadding(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount:  listQuestionsResponse.length,
                itemBuilder: (BuildContext context, int index){
                  if( listQuestionsResponse[index].correct == 0 &&  listQuestionsResponse[index].skipped == 0){

                    return GestureDetector(

                      onTap: (){
                        setState(() {
                          listWrongReviewQuestionsResponse.clear();
                          listWrongReviewQuestionsResponse.add(listQuestionsResponse[index]);
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(color: listWrongReviewQuestionsResponse.contains(listQuestionsResponse[index]) ? Colors.deepPurpleAccent : Colors.transparent),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: appPadding(10),
                            margin: EdgeInsets.only(bottom: 10,left: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: sText("${listQuestionsResponse[index].text}",weight: FontWeight.bold,color: Colors.white38),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      FlutterSwitch(
                                        width: 50.0,
                                        height: 20.0,
                                        valueFontSize: 10.0,
                                        toggleSize: 15.0,
                                        value: true,
                                        borderRadius: 30.0,
                                        padding: 2.0,
                                        showOnOff: false,
                                        activeColor: Colors.blue,
                                        inactiveColor: Colors.grey,
                                        inactiveTextColor: Colors.red,
                                        inactiveToggleColor: Colors.white,

                                        onToggle: (val) {
                                          setState(() {
                                          });
                                        },
                                      ),
                                      SizedBox(height: 40,),
                                      Container(
                                        child: Icon(Icons.close,color: Colors.white,),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 10,
                            child: sText("${index +1}.",weight: FontWeight.bold,size: 16),
                          )
                        ],
                      ),
                    );
                  }

                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
