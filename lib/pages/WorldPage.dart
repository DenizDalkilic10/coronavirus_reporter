import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/Models/World.dart';
import 'package:coronavirus_reporter/Services/FirestoreService.dart';
import 'package:coronavirus_reporter/controllers/ModelController.dart';
import 'package:coronavirus_reporter/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorldPage extends StatefulWidget {
  WorldPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  static World world;

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
            return worldPage(
                context, ModelController.world, widget.title, refresh);
          } else {
            return someThingWentWrong();
          }
        },
      );
    }
    return worldPage(context, ModelController.world, widget.title, refresh);
  }

  void refresh() async {
    ModelController.countries = await FirestoreService.getCountriesData();
    setState(() {
      ModelController.setWorld();
    });
  }
}
