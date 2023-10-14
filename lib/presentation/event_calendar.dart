import 'package:festiva/utility/components.dart';
import 'package:festiva/utility/event.dart' as es;
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class EventCalendarPage extends StatefulWidget {
  const EventCalendarPage(this.events, {super.key});
  final List<es.Event> events;

  @override
  State<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Calendar'),
      ),
      body: EventCalendar(
        calendarType: CalendarType.GREGORIAN,
        events: [
          for (es.Event e in widget.events)
            Event(
              child: eventCard(e, context),
              dateTime: CalendarDateTime(
                year: e.date.year,
                month: e.date.month,
                day: e.date.day,
                calendarType: CalendarType.GREGORIAN,
              ),
            ),
        ],
      ),
    );
  }
}
