import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'jaggy-brooms.000webhostapp.com';


class Exercise {
  int _enbr;
  String _ename;
  double _weight;
  int _reps;
  int _sets;
  String _pob;

  Exercise(this._pob,this._enbr, this._ename, this._weight, this._reps, this._sets);

  bool belongsToWorkout(String workoutName) {
    return _ename.toLowerCase().contains(workoutName.toLowerCase());
  }

  @override
  String toString() {
    return '$_pob : $_ename\n$_weight kg-$_reps reps -$_sets sets';
  }
}

List<Exercise> _exercises = [];

void updateExercises(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'GetExercises.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _exercises.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Exercise e = Exercise(
          row['POB'],
          int.parse(row['ENBR']),
          row['EName'],
          double.parse(row['Weight']),
          int.parse(row['Reps']),
          int.parse(row['Sets']),
        );
        _exercises.add(e);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}


void searchExercise(Function(String text) update, String ename) async {
  try {
    final url = Uri.https(_baseURL, 'SearchExercise.php', {'EName': ename});
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _exercises.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Exercise p = Exercise(
        row['POB'],
        int.parse(row['ENBR']),
        row['EName'],
        double.parse(row['Weight']),
        int.parse(row['Reps']),
        int.parse(row['Sets']),
      );
      _exercises.add(p);
      update(p.toString());
    }
  }
  catch(e) {
    update("can't load data");
  }
}

class ShowExercises extends StatelessWidget {
  const ShowExercises({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _exercises.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(5),
              width: width * 0.9, child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(child: Text(_exercises[index].toString(), style: const TextStyle(
                fontSize: 25,
              color: Colors.grey
            )))
          ]))
        ])
    );
  }
}
