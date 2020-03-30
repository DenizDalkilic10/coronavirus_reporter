class Country {
  String name;
  int totalCases;
  int newCases;
  int totalDeaths;
  int newDeaths;
  int totalRecovered;
  int activeCases;

  Country(String name,int totalCases,int newCases,int totalDeaths,int newDeaths,int totalRecovered,int activeCases){
    this.name = name;
    this.totalCases = totalCases;
    this.newCases = newCases;
    this.totalDeaths = totalDeaths;
    this.newDeaths = newDeaths;
    this.totalRecovered = totalRecovered;
    this.activeCases = activeCases;
  }
  
}
