import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workout_app/home_page2.dart';

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

void addWorkout() {

}

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


class ShowWorkout extends StatelessWidget {
  const ShowWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home2()),
            );
          },
          title: Column(children: [
            const SizedBox(height: 10),
            Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(5),
                width: width * 0.9, child: Row(children: [
              SizedBox(width: width * 0.15),
              Flexible(child: Text(_workouts[index].toString(), style: TextStyle(
                  fontSize: width * 0.045,
                color: Colors.white54
              )))
            ]))
          ]),
        )
    );
  }
}