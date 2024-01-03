import 'package:flutter/material.dart';
import 'exercise.dart';

class SearchExercises extends StatefulWidget {
  const SearchExercises({Key? key}) : super(key: key);

  @override
  State<SearchExercises> createState() => _SearchExercisesState();
}

class _SearchExercisesState extends State<SearchExercises> {

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


  void getExercise() {
    try {
      String name = _controllerName.text;
      searchExercise(update, name);
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
        title: const Text('Search for the Exercise'),
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
                    hintText: 'Exercise'
                )
            )
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: getExercise,
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