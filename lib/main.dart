import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const JackPotApp());

  Future<CaixaMegaSena> fetchPost() async {
    final http.Response response =  await http.get("https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return CaixaMegaSena.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load result');
    }
  }
}

class JackPotApp extends StatelessWidget {
  const JackPotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jack´s pot',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(title: 'Jack´s pot'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CaixaMegaSena {
  List number = List .filled(6, 0);
  var people;

  CaixaMegaSena({required this.number,this.people});

  factory CaixaMegaSena.fromJson(Map<String, dynamic> json) => CaixaMegaSena(
    number: json['listaDezenas'],
  );
}
