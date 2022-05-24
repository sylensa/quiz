import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:quiz/helper/helper.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
class DiagnosticTest extends StatefulWidget {
  const DiagnosticTest({Key? key}) : super(key: key);

  @override
  State<DiagnosticTest> createState() => _DiagnosticTestState();
}

class _DiagnosticTestState extends State<DiagnosticTest> {
  int _currentPage = 0;
  int _currentSlide = 0;
  List<Widget> slides = [];
  var timeSpent;
  CountdownTimerController? controller;
  CurrentRemainingTime? remainingTime;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 1200;
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

  set(){
    String htmlData = """<p>I. logical procedure for arriving at knowledge</p><p>II. knowledge that can be verified</p><p>III. knowledge that can never be changed</p>""";
    dom.Document document = htmlparser.parse(htmlData);
    /// sanitize or query document here
    Widget html = Html(
      data: htmlData,
    );

    return html;
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:     Container(
            width: appWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: map<Widget>(6, (index, url) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: sText("${index + 1}",color: 1 == index ? Colors.white : Colors.white38,size: 20),
                      ),
                      1 == index ?
                      Container(
                        width: 20,
                        height: 3,
                        decoration: BoxDecoration(color: 1 == index ? Colors.white : dPurple),
                      ) : Container(),
                    ],
                  ),
                );
              }),
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
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    remainingTime = time;
                    var dateFormat = DateFormat('h:m:s');
                    DateTime durationStart = dateFormat.parse('10:20:00');
                    DateTime durationEnd = dateFormat.parse('10:${remainingTime!.min}:${remainingTime!.sec}');

                    print('durationStart: $durationStart');
                    print('durationEnd: $durationEnd');

                    timeSpent = durationEnd.difference(durationStart);

                    print('difference: ${timeSpent.toString().substring(2,8).toString().split(".").first} hours');
                    // print(remainingTime!.sec);
                    if (time == null) {
                      return sText('Game over',color: Colors.green);
                    }
                    return sText('${time.min}:${time.sec}',color: Colors.green);
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
        Expanded(
          child: ListView(
            children: [

            ],
          ),
        ),

        Container(
            color: Colors.white,
            padding: appPadding(20),
            child:      Row(
              children: [
                solonOutlineButton(
                  content: Icon(Icons.arrow_back, color: Colors.green),
                  height: 50,
                  onPressed: () {
                    setState(() {
                      _currentPage -= 1;
                    });
                  },
                ),
                SizedBox(width: 5),
                Expanded(
                  child: solonOutlineButton(
                      content: sText('Submit', color: Colors.white, weight: FontWeight.bold),
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
  Widget imageQuestion() {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: appPadding(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50),)
            ),
            child: ListView(
              children: [

              ],
            ),
          ),
        ),

        Container(
            color: Colors.white,
            padding: appPadding(20),
            child:      Row(
              children: [
                solonOutlineButton(
                  content: Icon(Icons.arrow_back, color: Colors.green),
                  height: 50,
                  onPressed: () {
                    setState(() {
                      _currentPage -= 1;
                    });
                  },
                ),
                SizedBox(width: 5),
                Expanded(
                  child: solonOutlineButton(
                      content: sText('Submit', color: Colors.white, weight: FontWeight.bold),
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

