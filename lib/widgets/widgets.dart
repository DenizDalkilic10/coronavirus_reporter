import 'package:coronavirus_reporter/Models/Constants.dart';
import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/Models/World.dart';
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
    body: PageView(
      children: <Widget>[
        CountriesPage(title: 'regional'),
        WorldPage(title: 'world')
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
      color: new Color(0xFF322366),
      child: Center(
        child: Loading(
            indicator: BallPulseIndicator(), size: 100.0, color: Colors.white),
      ));
}

Widget countryList(BuildContext context, List<Country> countries, String title,
    Function onSelected, Function refresh) {
  if (countries == null) return progressIndicator();
  ScrollController _scrollController = ScrollController();

  return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: refresh,
          child: Icon(MdiIcons.refresh // add custom icons also
              ),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(MdiIcons.sort),
            onSelected: onSelected,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice,
                    child: new Text(
                      choice,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0),
                    ));
              }).toList();
            },
          )
        ],
        centerTitle: true,
        title: new Text(title,
            style: TextStyle(
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
      backgroundColor: new Color(0xFF322366),
      body: countriesListView(context, countries, _scrollController));
}

Widget worldPage(BuildContext context, World world, String title, Function refresh) {
  if (world == null) return progressIndicator();
  ScrollController _scrollController = ScrollController();
  return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: refresh,
          child: Icon(MdiIcons.refresh // add custom icons also
              ),
        ),
        centerTitle: true,
        title: new Text(title,
            style: TextStyle(
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
      backgroundColor: new Color(0xFF322366),
      body: DraggableScrollbar.semicircle(
          backgroundColor: Colors.blueAccent,
          padding: EdgeInsets.zero,
          controller: _scrollController,
          child: ListView(
              controller: _scrollController,
              physics: ScrollPhysics().applyTo(AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                    margin: new EdgeInsets.fromLTRB(50, 30, 50, 30),
                    child: new Row(children: <Widget>[
                      Icon(
                        MdiIcons.earth,
                        size: 100,
                        color: Colors.greenAccent,
                      ),
                      new Text(
                          "  Total Cases \n  " + world.totalCases.toString(),
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height / 28)),
                    ])),
                Container(
                    margin: new EdgeInsets.fromLTRB(50, 30, 50, 30),
                    child: new Row(children: <Widget>[
                      Icon(
                        MdiIcons.graveStone,
                        size: 100,
                        color: Colors.redAccent,
                      ),
                      new Text(
                          "  Total Deaths \n  " + world.totalDeaths.toString(),
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height / 28)),
                    ])),
                Container(
                    margin: new EdgeInsets.fromLTRB(50, 30, 50, 30),
                    child: new Row(children: <Widget>[
                      Icon(
                        MdiIcons.hospitalBuilding,
                        size: 100,
                        color: Colors.blueAccent,
                      ),
                      new Text(
                          "  Active Cases \n  " + world.activeCases.toString(),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height / 28)),
                    ])),
                Container(
                    margin: new EdgeInsets.fromLTRB(50, 30, 50, 30),
                    child: new Row(children: <Widget>[
                      Icon(
                        MdiIcons.ambulance,
                        size: 100,
                        color: Colors.yellowAccent,
                      ),
                      new Text("  New Cases \n  " + world.newCases.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height / 28)),
                    ])),
                Container(
                    margin: new EdgeInsets.fromLTRB(50, 30, 50, 30),
                    child: new Row(children: <Widget>[
                      Icon(MdiIcons.bandage, size: 100, color: Colors.white),
                      new Text(
                          "  Recovered \n  " + world.totalRecovered.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height / 28)),
                    ])),
                Container(
                    margin: new EdgeInsets.fromLTRB(50, 30, 50, 30),
                    child: new Row(children: <Widget>[
                      Icon(
                        MdiIcons.church,
                        size: 100,
                        color: Colors.pink,
                      ),
                      new Text("  New Deaths \n  " + world.newDeaths.toString(),
                          style: TextStyle(
                              color: Colors.pink,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height / 28)),
                    ]))
              ])));
}

Widget countriesListView(BuildContext context, List<Country> countries,
    ScrollController _scrollController) {
  return DraggableScrollbar.semicircle(
      backgroundColor: Colors.blueAccent,
      padding: EdgeInsets.zero,
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        physics:
            BouncingScrollPhysics().applyTo(AlwaysScrollableScrollPhysics()),
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return countryRow(countries[index]);
        },
      ));
}

Widget countryRow(Country country) {
  final countryCard = new Container(
    height: 150.0,
    margin: new EdgeInsets.only(left: 46.0),
    child: new Container(
        height: 150,
        child: new Stack(children: <Widget>[
          Positioned(
            left: 25,
            child: new Text(country.name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0)),
          ),
          Positioned(
            top: 25,
            left: 90,
            child: new Text("Total Cases \n" + country.totalCases.toString(),
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0)),
          ),
          Positioned(
            top: 25,
            left: 220,
            child: new Text("Total Deaths \n" + country.totalDeaths.toString(),
                style: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0)),
          ),
          Positioned(
            top: 105,
            left: 90,
            child: new Text("Active Cases \n" + country.activeCases.toString(),
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0)),
          ),
          Positioned(
            left: 90,
            top: 65,
            child: new Text("New Cases \n" + country.newCases.toString(),
                style: TextStyle(
                    color: Colors.yellowAccent,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0)),
          ),
          Positioned(
            top: 105,
            left: 220,
            child: new Text("Recovered \n" + country.totalRecovered.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0)),
          ),
          Positioned(
            top: 65,
            left: 220,
            child: new Text("New Deaths \n" + country.newDeaths.toString(),
                style: TextStyle(
                    color: Colors.pink,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0)),
          )
        ])),
    decoration: new BoxDecoration(
      color: new Color(0xFF343366),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 5.0,
          offset: new Offset(0.0, 5.0),
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
            fit: BoxFit.fitHeight,
            image: new AssetImage("assets/images/" + country.name + ".png")),
      ));

  return new Container(
      height: 150.0,
      margin: EdgeInsets.fromLTRB(24, 40, 24, 0),
      child: new Stack(
        children: <Widget>[
          countryCard,
          Positioned(top: 23, child: countryThumbnail),
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
