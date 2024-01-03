import 'package:flutter/material.dart';
import 'workout.dart';
import 'search_workout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    updateWorkouts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false;
              updateWorkouts(update);
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            setState(() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchWorkouts())
              );
            });
          }, icon: const Icon(Icons.search))
        ],
          title: const Text('Choose Workout '),
          centerTitle: true,
        ),

        body: _load ? const ShowWorkout() : const Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator()
            )
        )
    );
  }
}
