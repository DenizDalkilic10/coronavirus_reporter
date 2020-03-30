import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus_reporter/Models/Country.dart';

class FirestoreService {
  static Firestore db = Firestore.instance;

  static Future<List<Country>> getCountriesData() async {
    print("Future start ");
    List<Country> countries = List<Country>();

    QuerySnapshot countriesSnapshot = await db
        .collection('countries')
        .orderBy("total_deaths", descending: true)
        .getDocuments();

    countriesSnapshot.documents.forEach((DocumentSnapshot snapshot) {
      Country country = Country(
          snapshot.data["name"],
          snapshot.data["total_cases"],
          snapshot.data["new_cases"],
          snapshot.data["total_deaths"],
          snapshot.data["new_deaths"],
          snapshot.data["total_recovered"],
          snapshot.data["active_cases"]);
      countries.add(country);
    });
    print("Future end");
    return countries;
  }
}
