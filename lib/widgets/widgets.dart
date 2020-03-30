import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/pages/CountriesPage.dart';
import 'package:coronavirus_reporter/pages/WorldPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

Scaffold homeScreen(BuildContext context, PageController pageController,
    int pageIndex, Function onpagechanged, Function onTap) {
  return Scaffold(
    body: PageView(
      children: <Widget>[
        CountriesPage(title: 'Flutter Demo Home Page'),
        WorldPage(title: 'Flutter Demo Home Page')
      ],
      controller: pageController,
      onPageChanged: onpagechanged, //sets the pageIndex
      physics: NeverScrollableScrollPhysics(),
    ),
    bottomNavigationBar: CupertinoTabBar(
      currentIndex: pageIndex,
      onTap: onTap, //pageController jumps to page
      activeColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.whatshot),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
        ),
      ],
    ),
  );
}

Widget progressIndicator() {
  return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Loading(
            indicator: BallPulseIndicator(), size: 100.0, color: Colors.pink),
      ));
}

Widget countryList(
    BuildContext context, String title, int _counter, List<Country> countries) {
  if (countries == null) return progressIndicator();
  
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    ),
  );
}
