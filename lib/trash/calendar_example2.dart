// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class CalendarExample2 extends StatefulWidget {
//   const CalendarExample2({super.key});

//   @override
//   State<CalendarExample2> createState() => _CalendarExample2State();
// }

// class _CalendarExample2State extends State<CalendarExample2> {
//   CalendarView view = CalendarView.day;

//   void _onViewChanged(int index) {
//     setState(() {
//       switch (index) {
//         case 0:
//           view = CalendarView.day;
//           break;
//         case 1:
//           view = CalendarView.week;
//           break;
//         case 2:
//           view = CalendarView.month;
//           break;
//         default:
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: 300,
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ButtonBar(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   TextButton(
//                     child: const Text("Day"),
//                     onPressed: () => _onViewChanged(0),
//                   ),
//                     TextButton(
//                     child: const Text("Week"),
//                     onPressed: () => _onViewChanged(1),
//                   ),
//                   TextButton(
//                     child: const Text("Month"),
//                     onPressed: () => _onViewChanged(2),
//                   ),
//                 ],
//               ),
//               SfCalendar(
//                 key: ValueKey(view),
//                 view: view,
//               )
//             ]));
//   }
// }
