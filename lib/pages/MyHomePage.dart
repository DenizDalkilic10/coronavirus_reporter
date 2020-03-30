import 'package:coronavirus_reporter/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  PageController pageController;
  
  @override
  void initState(){
    super.initState();
    pageController = PageController();
  }
    

  @override
  Widget build(BuildContext context) {
    return homeScreen(context, pageController, pageIndex, onPageChanged, onTap);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  void onTap(int pageIndex){
    pageController.jumpToPage(pageIndex);
  }
}