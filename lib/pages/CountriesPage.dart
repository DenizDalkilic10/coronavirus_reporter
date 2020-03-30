import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/Services/FirestoreService.dart';
import 'package:coronavirus_reporter/controllers/ModelController.dart';
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
  @override
  Widget build(BuildContext context) {
    if (ModelController.countries == null) {
      return FutureBuilder(
        future: FirestoreService.getCountriesData(),
        builder: (context, AsyncSnapshot<List<Country>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return progressIndicator();
          } else if (snapshot.data != null) {
            ModelController.setCountries(snapshot.data);
            ModelController.setWorld();
            return countryList(context, ModelController.countries, widget.title,
                onSelected, refresh);
          } else {
            return someThingWentWrong();
          }
        },
      );
    }

    return countryList(
        context, ModelController.countries, widget.title, onSelected, refresh);
  }

  void onSelected(String selection) {
    setState(() {
      ModelController.sortField = selection;
      ModelController.sortCountries(selection);
    });
  }

  void refresh() async {
    ModelController.countries = await FirestoreService.getCountriesData();
    setState(() {
      ModelController.sortCountries(ModelController.sortField);
    });
  }
}
