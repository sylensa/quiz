import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/helper/helper.dart';
import 'package:quiz/pages/review/all_review_questions.dart';
import 'package:quiz/pages/review/correct_review.dart';
import 'package:quiz/pages/review/not_attempted_review.dart';
import 'package:quiz/pages/review/wrong_review.dart';


class Review extends StatefulWidget {
  Review();
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool progressCode = true;
  int indicator = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appMainDarkGrey,
      child: SafeArea(
        top: true,
        bottom: false,
        maintainBottomViewPadding: false,
        child: Scaffold(
            backgroundColor: appMainDarkGrey ,
            body:  Container(
              child: SABT(
                child: DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: NestedScrollView(
                    physics: ClampingScrollPhysics(),
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          elevation: 1,
                          leading: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Center(child: Icon(Icons.arrow_back,)),
                          ),
                          centerTitle: false,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              sText("Reviews",weight: FontWeight.bold,size: 16,color: Colors.white),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: sText("History",color: Colors.grey),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.grey)
                                ),
                              )
                            ],
                          ),
                          actions: [

                          ],
                          // expandedHeight: appHeight(context)/2.1,
                          expandedHeight: 50,
                          floating: true,
                          pinned: false,
                          snap: true,
                          backgroundColor:appMainDarkGrey,

                        ),
                        SliverPersistentHeader(
                          floating: false,
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              onTap: (int i){
                                setState(() {
                                  indicator = i;
                                });
                                print("$i");
                              },
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              indicatorPadding: EdgeInsets.symmetric(horizontal: 0),
                              labelColor:  Colors.white,
                              indicatorColor: appMainDarkGrey ,
                              unselectedLabelColor: Colors.grey,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorWeight: 5,
                              isScrollable: true,
                              labelStyle:  TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                              unselectedLabelStyle:  TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                              tabs: [
                                Tab(
                                  text: "All",
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: bottomPadding(10),
                                        child: Icon(Icons.verified,color: Colors.green,size: 16,),
                                      ),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: sText("Correct",color: indicator == 1 ? Colors.white : Colors.grey,weight: FontWeight.bold,align: TextAlign.center),
                                          ),
                                          Container(
                                            child: sText("Answer",color: indicator == 1 ? Colors.white : Colors.grey,weight: FontWeight.bold,align: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: bottomPadding(10),
                                        child: Icon(Icons.cancel,color: Colors.red,size: 16,),
                                      ),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: sText("Wrong",color: indicator == 2 ? Colors.white : Colors.grey,weight: FontWeight.bold,align: TextAlign.center),
                                          ),
                                          Container(
                                            child: sText("Answer",color: indicator == 2 ? Colors.white : Colors.grey,weight: FontWeight.bold,align: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: bottomPadding(10),
                                        child: Icon(Icons.question_mark_rounded,color: Colors.white,size: 16,),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: sText("Not",color: indicator == 3 ? Colors.white : Colors.grey,weight: FontWeight.bold,align: TextAlign.center),
                                          ),
                                          Container(
                                            child: sText("Attempted",color: indicator == 3 ? Colors.white : Colors.grey,weight: FontWeight.bold,align: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          pinned: true,
                        ),


                      ];

                    },

                    body:   TabBarView(
                      children: [
                        AllReviewQuestions(),
                        CorrectReview(),
                        WrongReview(),
                        NotAttemptedReview(),
                        // Requests(),
                        // StaredRanks(),

                      ],
                    ),
                  ),
                ),
              ),
            )
        ),
      ),
    );

  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return  Container(

        padding: EdgeInsets.only(left: 20,right: 20,top: 0),

        color: appMainDarkGrey ,
        child: _tabBar
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _SABTState createState() {
    return new _SABTState();
  }
}
class _SABTState extends State<SABT> {
  ScrollPosition? _position;
  bool? _visible;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }
  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }
  void _removeListener() {
    _position?.removeListener(_positionListener);
  }
  void _positionListener() {
    final FlexibleSpaceBarSettings? settings = context.dependOnInheritedWidgetOfExactType(aspect: FlexibleSpaceBarSettings);
    bool visible = settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible!,
      child: widget.child,
    );
  }
}

