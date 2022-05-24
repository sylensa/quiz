import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz/helper/helper.dart';
import 'package:quiz/pages/diagnostic_test.dart';


class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {





  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              goTo(context, DiagnosticTest(),replace: true);
            },
            child: Container(
              child: sText("Skip",color: Colors.green,align: TextAlign.center),
              padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft:  Radius.circular(30))
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: sText("Welcome to the Adeo Experience",color: Colors.white,size: 30,align: TextAlign.center),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text.rich(

                TextSpan(
                    text: 'You currently have ',
                    style: appStyle(col: Colors.white),

                    children: <InlineSpan>[

                      TextSpan(
                        text:'No',
                        style: appStyle(col: Colors.white,weight: FontWeight.bold),

                      ),

                      TextSpan(
                        text:' Subscriptions.',
                        style: appStyle(col: Colors.white),

                      )
                    ]
                ),



              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 33),
              child: sText("First take a diagnostic test to determine the right course for you",color: Colors.white,align: TextAlign.center),
            ),

            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                goTo(context, DiagnosticTest(),replace: true);
              },
              child: Container(
                child: sText("Let's go",weight: FontWeight.bold,color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
