import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'jaggy-brooms.000webhostapp.com';


class Workout {
  int _bid;
  String _pob;

  Workout(this._bid, this._pob);

  @override
  String toString() {
    return _pob;
  }
}

List<Workout> _workouts = [];

void updateWorkouts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'GetWorkouts.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _workouts.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Workout w = Workout(
            int.parse(row['Bid']),
            row['POB'],
            );
        _workouts.add(w);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}


void searchWorkouts(Function(String text) update, String name) async {
  try {
    final url = Uri.https(_baseURL, 'SearchWorkout.php', {'POB':name});
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _workouts.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Workout w = Workout(
        int.parse(row['Bid']),
        row['POB'],
      );
      _workouts.add(w);
      update(w.toString());
    }
  }
  catch(e) {
    update("can't load data");
  }
}


class ShowWorkout extends StatelessWidget {
  const ShowWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: index % 2 == 0 ? Colors.grey: Colors.grey[350],
              padding: const EdgeInsets.all(5),
              width: width * 0.9, child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(child: Text(_workouts[index].toString(), style: TextStyle(fontSize: width * 0.045)))
          ]))
        ])
    );
  }
}