import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/Services/FirestoreService.dart';
import 'package:coronavirus_reporter/widgets/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountriesPage extends StatefulWidget {
  CountriesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {

  static List<Country> countries;

  @override
  Widget build(BuildContext context) {
    if (countries == null) {
      return FutureBuilder(
        future: FirestoreService.getCountriesData(),
        builder: (context, AsyncSnapshot<List<Country>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return progressIndicator();
          } else if (snapshot.data != null) {
            countries = snapshot.data;
            return countryList(context, countries);
          } else {
            return someThingWentWrong();
          }
        },
      );
    }

    return countryList(context, countries);
  }
}
