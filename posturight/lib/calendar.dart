// import 'package:flutter/material.dart';
// import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:packages_test/horizontal_week_calendar/horizontal_week_calendar.dart';
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Packages Test',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       home: const HorizontalWeekCalendarPackage(),
//     );
//   }
// }
// class HorizontalWeekCalendarPackage extends StatefulWidget {
//   const HorizontalWeekCalendarPackage({super.key});
//   @override
//   State<HorizontalWeekCalendarPackage> createState() =>
//       _HorizontalWeekCalendarPackageState();
// }
// class _HorizontalWeekCalendarPackageState
//     extends State<HorizontalWeekCalendarPackage> {
//   var selectedDate = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: const Text(
//           "Horizontal Week Calendar",
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               HorizontalWeekCalendar(
//                 weekStartFrom: WeekStartFrom.Monday,
//                 activeBackgroundColor: Colors.purple,
//                 activeTextColor: Colors.white,
//                 inactiveBackgroundColor: Colors.purple.withOpacity(.3),
//                 inactiveTextColor: Colors.white,
//                 disabledTextColor: Colors.grey,
//                 disabledBackgroundColor: Colors.grey.withOpacity(.3),
//                 activeNavigatorColor: Colors.purple,
//                 inactiveNavigatorColor: Colors.grey,
//                 monthColor: Colors.purple,
//                 onDateChange: (date) {
//                   setState(() {
//                     selectedDate = date;
//                   });
//                 },
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Selected Date",
//                       textAlign: TextAlign.center,
//                       style: theme.textTheme.titleMedium!.copyWith(
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 3),
//                     Text(
//                       DateFormat('dd MMM yyyy').format(selectedDate),
//                       textAlign: TextAlign.center,
//                       style: theme.textTheme.titleLarge!.copyWith(
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:calender_picker/calender_picker.dart';

import 'package:calender_picker/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horizontal Calendar Demo',
      home: CalendarPage(title: 'Calendar Single Selection'),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime dateTime = DateTime.now();

  int days = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: const Color(0XFF0342E9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Scheduled Workout',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  InkWell(
                    onTap: () => Get.bottomSheet(
                        SfDateRangePicker(
                          selectionMode: DateRangePickerSelectionMode.range,
                          view: DateRangePickerView.month,
                          onSelectionChanged: _onSelectionChanged,
                        ),
                        backgroundColor: Colors.white),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0XFFEDF3FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0XFF0342E9),
                          ),
                        )),
                  )
                ],
              ),
            ),
            CalenderPicker(
              dateTime,
              daysCount: days,
              // ignore: avoid_print
              enableMultiSelection: true,
              // ignore: avoid_print
              multiSelectionListener: (value) => print(value),
              selectionColor: const Color(0XFF0342E9),
              selectedTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  different({DateTime? first, DateTime? last}) async {
    int data = last!.difference(first!).inDays;
    // ignore: avoid_print

    setState(() {
      data++;
      days = data;
      // ignore: avoid_print
      print(data);
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        dateTime = args.value.startDate;

        if (args.value.endDate != null) {
          different(first: args.value.startDate, last: args.value.endDate);
          // ignore: avoid_print
          print(args.value.startDate);
          // ignore: avoid_print
          print(args.value.endDate);
        }
      });
    }
  }
}