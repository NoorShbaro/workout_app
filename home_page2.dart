import 'package:flutter/material.dart';
import 'exercise.dart';
import 'search_exercise.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('failed to load data')
            )
        );
      }
    });
  }


  @override
  void initState() {
    updateExercises(update);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false;
              updateExercises(update);
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            setState(() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchExercises())
              );
            });
          }, icon: const Icon(Icons.search))
        ],
          title: const Text('Exercise'),
          centerTitle: true,
        ),

        body: _load ? const ShowExercises() : const Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator()
            )
        )
    );
  }
}