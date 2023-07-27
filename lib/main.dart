import 'package:flutter/material.dart';
import 'package:kniffelblock/upper_section_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kniffelblock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreenAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Kniffel'),
      ),
      body: ListView(
        children: const [ObenDisplay(), UntenDisplay()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Zeige Spieler',
        child: const Icon(Icons.backup_table),
      ),
    );
  }
}

Widget labelText(String text, BuildContext ctx) {
  return Text(text,
      style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
          color: Theme.of(ctx).colorScheme.primary,
          fontWeight: FontWeight.w600));
}

class ObenDisplay extends StatefulWidget {
  const ObenDisplay({super.key});

  @override
  State<ObenDisplay> createState() => _ObenDisplayState();
}

Widget tappableListItem(
    {required String text,
    required IconData leadingIcon,
    String? description,
    dynamic tapEvent,
    required BuildContext context}) {
  return ListTile(
      title: Text(text),
      subtitle: (description != null)
          ? Text(description,
              style: const TextStyle(color: Colors.grey, fontSize: 14.0))
          : null,
      leading: Icon(leadingIcon, color: Theme.of(context).colorScheme.primary),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        tapEvent();
      });
}

upperTapEvent(
    BuildContext context, String title, int multiplier, IconData icon) {
  return () {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UpperSection(title: title, multiplier: multiplier, icon: icon)),
    );
  };
}

class _ObenDisplayState extends State<ObenDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
            child: labelText('Oben', context),
          ),
          ...[
            ['Einser', Icons.looks_one_rounded],
            ['Zweier', Icons.looks_two_rounded],
            ['Dreier', Icons.looks_3_rounded],
            ['Vierer', Icons.looks_4_rounded],
            ['Fünfer', Icons.looks_5_rounded],
            ['Sechser', Icons.looks_6_rounded],
          ].asMap().entries.map((entry) {
            int idx = entry.key + 1;
            dynamic val = entry.value;
            return tappableListItem(
                text: val[0],
                description: 'Nur ${val[0]} zählen',
                leadingIcon: val[1],
                context: context,
                tapEvent: upperTapEvent(context, val[0], idx, val[1]));
          }).toList()
        ]);
  }
}

class UntenDisplay extends StatelessWidget {
  const UntenDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
        child: labelText('Unten', context),
      ),
      ...[
        ['Dreierpasch', 'Alle Augen zählen', Icons.casino_outlined],
        ['Viererpasch', 'Alle Augen zählen', Icons.casino_outlined],
        ['Full House', '25 Punkte', Icons.house_rounded],
        ['Kleine Straße', '30 Punkte', Icons.signpost_rounded],
        ['Große Straße', '40 Punkte', Icons.signpost_rounded],
        ['Kniffel', '50 Punkte', Icons.casino_rounded],
        ['Chance', 'Alle Augen zählen', Icons.restart_alt_rounded]
      ].map((l) {
        return tappableListItem(
            text: l[0].toString(),
            description: l[1].toString(),
            context: context,
            leadingIcon: l[2] as IconData);
      }).toList(),
      const Padding(padding: EdgeInsets.only(bottom: 16.0))
    ]);
  }
}
