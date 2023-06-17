// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalenderExample extends StatefulWidget {
//   const CalenderExample({super.key});

//   @override
//   State<CalenderExample> createState() => _CalenderExampleState();
// }

// class _CalenderExampleState extends State<CalenderExample> {
//   DateTime today = DateTime.now();
//   void _onDaySelected(DateTime day, DateTime focusedDay) {
//     setState(() {
//       today = day;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: 300,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TableCalendar(
//               locale: "de_DE",
//               availableGestures: AvailableGestures.all, // only useful for mobile
//               selectedDayPredicate: (day) => isSameDay(day, today),
//               onDayLongPressed: (selectedDay, focusedDay) => [],
//               firstDay: DateTime.utc(1950, 1, 1),
//               lastDay: DateTime.utc(2030, 12, 31),
//               focusedDay: DateTime.now(),
//               onDaySelected: _onDaySelected,
//             )
//           ],
//         ));
//   }
// }
