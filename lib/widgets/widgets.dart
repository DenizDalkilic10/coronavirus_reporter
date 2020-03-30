import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/pages/CountriesPage.dart';
import 'package:coronavirus_reporter/pages/WorldPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

Scaffold homeScreen(BuildContext context, PageController pageController,
    int pageIndex, Function onpagechanged, Function onTap) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: new Text("Covid-19",
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 30.0)),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.lightBlueAccent, Colors.blue])),
      ),
    ),
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
          icon: Icon(MdiIcons.cityVariant, size: 35),
        ),
        BottomNavigationBarItem(icon: Icon(MdiIcons.earth, size: 35)),
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

Widget countryList(BuildContext context, List<Country> countries) {
  if (countries == null) return progressIndicator();
  ScrollController _scrollController = ScrollController();
  return Scaffold(
      //appBar: customAppBar(context, 66.8, "Countries"),
      body: countriesListView(context, countries, _scrollController));
}

Widget countriesListView(BuildContext context, List<Country> countries,
    ScrollController _scrollController) {
  int itemExtent = 150;
  return DraggableScrollbar.semicircle(
      backgroundColor: Colors.blueAccent,
      padding: EdgeInsets.zero,
      labelTextBuilder: (double offset) => Text(
          countries[(offset ~/ itemExtent)].totalDeaths.toString(),
          style: TextStyle(color: Colors.white)),
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        physics:
            BouncingScrollPhysics().applyTo(AlwaysScrollableScrollPhysics()),
        itemCount: countries.length,
        itemBuilder: (context, index){
          return countryRow(countries[index]);
        },
      ));
}

Widget countryRow(Country country) {
  final countryCard = new Container(
    height: 124.0,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
      color: new Color(0xFF333366),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );

  //country name should be converted to country code using the json file
  final countryThumbnail = new Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
            fit: BoxFit.fill,
            image: new AssetImage("assets/images/" + country.name + ".png")),
      ));

  return new Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          countryCard,
          Positioned(top: 10, child: countryThumbnail),
        ],
      ));
}

Widget someThingWentWrong() {
  return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Loading(
            indicator: BallPulseIndicator(), size: 100.0, color: Colors.pink),
      ));
}

