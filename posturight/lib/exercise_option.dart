import 'package:flutter/material.dart';

class Exercise {
  final String name;
  //final String description;
  final String image;
  final String url;

  const Exercise({required this.name, required this.image, required this.url});
}

final exercises = [
  Exercise(
    name: 'Downward-Dog',
    //description: 'Push-ups work multiple muscle groups including the chest, shoulders, triceps, and core.',
    image: 'Downward-Facing.png',
    url: 'https://www.youtube.com/watch?v=EC7RGJ975iM&ab_channel=AloMoves-OnlineYoga%26FitnessVideos',
  ),
  Exercise(
    name: 'Child-Pose',
    //description: 'Squats work the muscles in your lower body, including your quadriceps, hamstrings, and glutes.',
    image: 'ChildsPose.png',
    url: 'https://www.youtube.com/watch?v=qYvYsFrTI0U&ab_channel=ViveHealth',
  ),
  Exercise(
    name: 'Plank',
   // description: 'The plank is a great exercise for strengthening your core muscles.',
    image: 'plank.png',
    url: 'https://www.youtube.com/watch?v=pvIjsG5Svck&ab_channel=Children%27sHospitalColorado',
  ),
];

class ExerciseList extends StatelessWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise List'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(exercises[index].image),
            title: Text(exercises[index].name),
            //subtitle: Text(exercises[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetail(exercise: exercises[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExerciseDetail extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetail({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(exercise.image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            //child: Text(exercise.description),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Open the exercise URL in a browser
              },
              child: const Text('View Exercise'),
            ),
          ),
        ],
      ),
    );
  }
}
