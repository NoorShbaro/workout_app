import 'package:flutter/material.dart';
import 'workout.dart';

class SearchWorkout extends StatefulWidget {
  const SearchWorkout({Key? key}) : super(key: key);

  @override
  State<SearchWorkout> createState() => _SearchWorkoutState();
}

class _SearchWorkoutState extends State<SearchWorkout> {

  final TextEditingController _controllerName = TextEditingController();
  String _text = '';


  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }


  void getWorkout() {
    try {
      String name = _controllerName.text;
      searchWorkouts(update, name);
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('wrong arguments')
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for the Workout'),
        centerTitle: true,
      ),
      body: Center(child: Column(children: [
        const SizedBox(height: 10),
        SizedBox(
            width: 200,
            child: TextField(
                controller: _controllerName,
                keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Workout'
            )
            )
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: getWorkout,
            child: const Text(
                'Find',
                style: TextStyle(fontSize: 18)
            )
        ),
        const SizedBox(height: 10),
        Center(
            child: SizedBox(
                width: 200,
                child: Flexible(
                    child: Text(
                        _text,
            style: const TextStyle(fontSize: 18)
        )
        )
        )
        ),
      ],

      ),

      ),
    );
  }
}