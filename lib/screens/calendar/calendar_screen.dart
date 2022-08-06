
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/palette.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
   //late final ValueNotifier<List<Event>> _selectedEvents;

  //final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  get kEvents => null;

  @override
  void initState() {
    super.initState();

    //_selectedDay = _focusedDay;
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    //_selectedEvents.dispose();
    super.dispose();
  }

  // List<Event> _getEventsForDay(DateTime day) {
  //   // Implementation example
  //   return kEvents[day] ?? [];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      //_selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar( //TableCalendar<Event>(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            //eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            // onDaySelected: (selectedDay, focusedDay) {
            //   if (!isSameDay(_selectedDay, selectedDay)) {
            //     // Call `setState()` when updating the selected day
            //     setState(() {
            //       _selectedDay = selectedDay;
            //       _focusedDay = focusedDay;
            //     });
            //   }
            // },
            onDaySelected: _onDaySelected,
            daysOfWeekHeight: 30,
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                switch (day.weekday) {
                  case 1:
                    return const Center(
                      child: Text('월'),
                    );
                  case 2:
                    return const Center(
                      child: Text('화'),
                    );
                  case 3:
                    return const Center(
                      child: Text('수'),
                    );
                  case 4:
                    return const Center(
                      child: Text('목'),
                    );
                  case 5:
                    return const Center(
                      child: Text('금'),
                    );
                  case 6:
                    return const Center(
                      child: Text('토'),
                    );
                  case 7:
                    return const Center(
                      child: Text(
                        '일',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                }
                return null;
              },
            ),
            //요일
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              defaultTextStyle: const TextStyle(
                color: Colors.black87,
              ),
              weekendTextStyle: const TextStyle(color: Colors.black87),
              outsideDaysVisible: true,
              todayDecoration: BoxDecoration(
                  color: Palette.mainColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.transparent, width: 1)),
              todayTextStyle: const TextStyle(color: Colors.white),
            ),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          // Expanded(
          //         child: ValueListenableBuilder<List<Event>>(
          //             valueListenable: _selectedEvents,
          //             builder: (context, value, _) {
          //               return ListView.builder(
          //                   itemCount: value.length,
          //                   itemBuilder: (context, index) {
          //                     return Container(
          //                       margin: const EdgeInsets.symmetric(
          //                         horizontal: 12.0,
          //                         vertical: 4.0,
          //                       ),
          //                       decoration: BoxDecoration(
          //                         border: Border.all(),
          //                         borderRadius: BorderRadius.circular(12.0),
          //                       ),
          //                       child: ListTile(
          //                         onTap: () => print('${value[index]}'),
          //                         title: Text('${value[index]}'),
          //                       ),
          //                     );
          //                   });
          //             }))
        ],
      ),
    );
  }
}
