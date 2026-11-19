import 'package:flutter/material.dart';
import '../covid_data.dart';

String formatDate(DateTime d) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(d.day)}/${two(d.month)}/${d.year} '
      '${two(d.hour)}:${two(d.minute)}';
}

class CovidCard extends StatelessWidget {
  final CovidData data;
  final VoidCallback onNotify;

  const CovidCard({super.key, required this.data, required this.onNotify});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (data.flag.isNotEmpty)
          Center(
            child: Image.network(
              data.flag,
              height: 80,
              errorBuilder: (_, __, ___) => const Icon(Icons.flag, size: 80),
            ),
          ),
        const SizedBox(height: 12),
        Text(
          data.country,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        Text('Casos acumulados: ${data.cases}'),
        Text('Casos del día: ${data.todayCases}'),
        Text('Muertes acumuladas: ${data.deaths}'),
        Text('Muertes del día: ${data.todayDeaths}'),
        Text('Recuperados: ${data.recovered}'),
        Text('Actualizado: ${formatDate(data.updated)}'),
        const Spacer(),
        FilledButton(
          onPressed: onNotify,
          child: const Text('Enviar notificación'),
        ),
      ],
    );
  }
}