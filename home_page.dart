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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(actions: [
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
            }, icon: const Icon(Icons.search)),
          ],
            title: const Padding(
              padding: EdgeInsets.fromLTRB(20.0,10,20,0),
              child:  Text(
                  'Choose Workout',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[200],

          ),
        ),

        body: _load ? const ShowWorkout() :const Column(
          children: [
            Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()
                    )
                ),
          ],
        ),
      backgroundColor: Colors.grey[500],
    );
  }
}
/*
*/
