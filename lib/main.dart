import 'package:flutter/material.dart';
import 'covid_api.dart';
import 'covid_data.dart';
import 'notification_service.dart';
import 'widgets/country_selector.dart';
import 'widgets/covid_card.dart';
import 'widgets/error_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de respaldo mientras carga la lista real (o si falla).
  List<String> countries = const [
    'Colombia', 'Mexico', 'Argentina', 'Peru', 'Chile', 'Spain', 'USA',
  ];
  String selected = 'Colombia';
  late Future<CovidData> future = fetchCountry(selected);

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final names = await fetchCountryNames();
      if (!mounted || !names.contains(selected)) return;
      setState(() => countries = names);
    } catch (_) {
      // Si falla, se conserva la lista de respaldo.
    }
  }

  void _reload() {
    setState(() {
      future = fetchCountry(selected);
    });
  }

  Future<void> _notify(CovidData d) async {
    await NotificationService.show(
      title: 'COVID-19: ${d.country}',
      body: 'Casos: ${d.cases} | Muertes: ${d.deaths} | Hoy: ${d.todayCases}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos COVID-19')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CountrySelector(
              countries: countries,
              selected: selected,
              onChanged: (value) {
                selected = value;
                _reload();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<CovidData>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return ErrorView(
                      error: snapshot.error!,
                      onRetry: _reload,
                    );
                  }
                  return CovidCard(
                    data: snapshot.data!,
                    onNotify: () => _notify(snapshot.data!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}