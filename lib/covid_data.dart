class CovidData {
  final String country;
  final String flag; // URL de la bandera (ampliación)
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final DateTime updated;

  CovidData({
    required this.country,
    required this.flag,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.updated,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic v) => (v as num?)?.toInt() ?? 0;
    final info = json['countryInfo'] as Map<String, dynamic>?;
    return CovidData(
      country: json['country'] as String,
      flag: (info?['flag'] as String?) ?? '',
      cases: toInt(json['cases']),
      todayCases: toInt(json['todayCases']),
      deaths: toInt(json['deaths']),
      todayDeaths: toInt(json['todayDeaths']),
      recovered: toInt(json['recovered']),
      updated: DateTime.fromMillisecondsSinceEpoch(toInt(json['updated'])),
    );
  }
}