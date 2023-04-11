import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Exercise {
  final String name;
  final String image;
  final String url;

  const Exercise({required this.name, required this.image, required this.url});
}

final exercises = [
  Exercise(
    name: 'Downward-Dog',
    image: 'assets/Downward-Facing.png',
    url: 'https://www.youtube.com/watch?v=EC7RGJ975iM&ab_channel=AloMoves-OnlineYoga%26FitnessVideos',
  ),
  Exercise(
    name: 'Child-Pose',
    image:'assets/ChildsPose.png',
    url: 'https://www.youtube.com/watch?v=qYvYsFrTI0U&ab_channel=ViveHealth',
  ),
  Exercise(
    name: 'Plank',
    image: 'assets/plank.png',
    url: 'https://www.youtube.com/watch?v=pvIjsG5Svck&ab_channel=Children%27sHospitalColorado',
  ),
  Exercise(
    name: 'Flexibility',
    image: 'assets/flexibility.png',
    url: 'https://www.youtube.com/watch?v=KsYUVCZzheQ&ab_channel=ToneandTighten'
  ),
  Exercise(
    name: 'Wall Slides',
    image: 'assets/wallslides.png',
    url: 'https://www.youtube.com/watch?v=W_p73Vqhs-8&ab_channel=ExcelPerformanceTraining',
  ),
  Exercise(
    name: 'Single leg extension',
    image: 'assets/singlelegextension.png',
    url: 'https://www.youtube.com/watch?v=IGqURwGxSwU&ab_channel=COREChiropractic',
  ),
  Exercise(
    name: 'Shoulder stretch',
    image: 'assets/shoulderstretch.png',
    url: 'https://www.youtube.com/watch?v=6jHsraw2NIk&ab_channel=AskDoctorJo',
  ),
  Exercise(
    name: 'Renegade Rows',
    image: 'assets/renegade.png',
    url: 'https://www.youtube.com/watch?v=Oh2o-WACBJk&ab_channel=TWDFitness-TransformwithDawnFitness',
  ),
  Exercise(
    name: 'Abdominal Bracing',
    image: 'assets/abdominal.png',
    url: 'https://www.youtube.com/watch?v=Fmawfgj-fHY&ab_channel=drverspine',
  ),
];

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({Key? key}) : super(key: key);

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
            leading:Image.asset(
              //'assets/ChildsPose.png',
              exercises[index].image,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            title: Text(exercises[index].name),
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
          Image.asset(exercise.image,
              width: 700,
              height: 400,
              fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                launchURL(exercise.url);
              },
              child: const Text('View Exercise'),
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
