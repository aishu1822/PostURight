import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class MyCard extends StatefulWidget {
  @override
  _MyCardState createState() => _MyCardState();
}
class _MyCardState extends State<MyCard> {
  String _text = "";
  double _progress = 0.0;
  void _updateText(String value) {
    setState(() {
      _text = value;
    });
  }
  void _updateProgress(double value) {
    setState(() {
      _progress = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [ 
                    Text("Achievements",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    /*style: AppStyle.txtSFProRegular14)*/),
                    Text("See more",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    /*style: AppStyle.txtSFProRegular14)*/),
              ],
            ),

            Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.start,
                      children: [
                        const Text(
                            "Maintain a 10 day streak",
                            overflow: TextOverflow
                                .ellipsis,
                            textAlign:TextAlign.left,
                            /* style: AppStyle.txtSFProRegular14*/),
                        Padding(
                            padding:const EdgeInsets.only(top: 3,),
                            child: Container(
                                height: 6,
                                width: 230,
                                decoration: BoxDecoration(
                                    // color: ColorConstant.blueGray10005,
                                    borderRadius:
                                        BorderRadius.circular(3)),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(3),
                                    child: const LinearProgressIndicator(
                                        value: 0.53,
                                        // backgroundColor: ColorConstant.blueGray10005,
                                        /*valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.teal400)*/)))),
                        const Padding(
                            padding: EdgeInsets.only(top: 5,),
                            child: Text("50% left",
                                overflow:TextOverflow.ellipsis,
                                textAlign:TextAlign.left,
                                /*style: AppStyle.txtSFProRegular12*/)
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Maintain a 20 day streak",
                              overflow: TextOverflow.ellipsis,
                              textAlign:TextAlign.left,
                              /*style: AppStyle.txtSFProRegular14*/),
                          ]
                      ),
                    ],


                )
                


          ],
        ),
      )
    );
  }
}