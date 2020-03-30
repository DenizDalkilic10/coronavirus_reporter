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
  int _counter = 0;
  List<Country> countries;

  @override
  Widget build(BuildContext context) {
    if (countries == null || countries.isEmpty) {
      return FutureBuilder(
        future: FirestoreService.getCountriesData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return progressIndicator();
          else if (snapshot.data != null)
            return Text((snapshot.data)[0].name.toString());
          else
            return Text("None");
        },
      );
    }

    return countryList(context, widget.title, _counter, countries);
  }
}
