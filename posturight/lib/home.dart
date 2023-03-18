import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);
  final String? title;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        
        Padding(padding: const EdgeInsets.all(10),),
        Wrap(children:[
        SizedBox(
                    height: 40,
                    width: 40,
                    child: 
                      Card(
                        // clipBehavior is necessary because, without it, the InkWell's animation
                        // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                        // This comes with a small performance cost, and you should not set [clipBehavior]
                        // unless you need it.
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            debugPrint('Card tapped.');
                          },
                          child: const SizedBox(
                            width: 300,
                            height: 100,
                            child: Text('A card that can be tapped'),
                          ),
                        ),
                      ),
                    
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: 
            Card(
              // clipBehavior is necessary because, without it, the InkWell's animation
              // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
              // This comes with a small performance cost, and you should not set [clipBehavior]
              // unless you need it.
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('A card that can be tapped'),
                ),
              ),
            ),
          
        ),
        ],
        ),
      ],

    );
  }
}