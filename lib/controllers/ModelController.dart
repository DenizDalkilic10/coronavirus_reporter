import 'package:coronavirus_reporter/Models/Country.dart';
import 'package:coronavirus_reporter/Models/World.dart';

class ModelController {
  static List<Country> countries;
  static String sortField = "total_deaths";
  static World world;

  static void setCountries(List<Country> countryList) {
    countries = countryList;
  }

  static void setWorld() {
    int totalCases = 0,
        totalDeaths = 0,
        totalRecovered = 0,
        newCases = 0,
        newDeaths = 0,
        activeCases = 0;

    for (Country country in countries) {
      totalCases += country.totalCases;
      totalDeaths += country.totalDeaths;
      totalRecovered += country.totalRecovered;
      newCases += country.newCases;
      newDeaths += country.newDeaths;
      activeCases += country.activeCases;
    }

    world = new World(totalCases, newCases, totalDeaths, newDeaths,
        totalRecovered, activeCases);
  }

  static void sortCountries(String field) {
    if (field == "Total Deaths")
      countries.sort((a, b) => b.totalDeaths.compareTo(a.totalDeaths));
    else if (field == "New Deaths")
      countries.sort((a, b) => b.newDeaths.compareTo(a.newDeaths));
    else if (field == "Total Cases")
      countries.sort((a, b) => b.totalCases.compareTo(a.totalCases));
    else if (field == "New Cases")
      countries.sort((a, b) => b.newCases.compareTo(a.newCases));
    else if (field == "Total Recovered")
      countries.sort((a, b) => b.totalRecovered.compareTo(a.totalRecovered));
    else if (field == "Active Cases")
      countries.sort((a, b) => b.activeCases.compareTo(a.activeCases));
    else if (field == "Alphabetical")
      countries.sort((a, b) => a.name.compareTo(b.name));
  }

  
}
