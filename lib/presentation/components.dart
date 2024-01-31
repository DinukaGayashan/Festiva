import 'package:festiva/presentation/event_page.dart';
import 'package:festiva/utility/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart' as es;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

List<Color> colorMap = [
  const Color(0xff795548),
  const Color(0xffff5722),
  const Color(0xffff9800),
  const Color(0xffffc107),
  const Color(0xffcddc39),
  const Color(0xff8bc34a),
  const Color(0xff4caf50),
  const Color(0xff009688),
  const Color(0xff00bcd4),
  const Color(0xff03a9f4),
  const Color(0xff2196f3),
  const Color(0xff00bcd4),
  const Color(0xff3f51b5),
  const Color(0xff673ab7),
  const Color(0xff9c27b0),
  const Color(0xffe91e63),
  const Color(0xfff44336)
];
Random random = Random();

Widget eventCard(Event event, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ListTile(
      minVerticalPadding: 20,
      leading: SizedBox(
        width: 80,
        child: Image.network(event.media.first),
      ),
      tileColor: colorMap[random.nextInt(colorMap.length)].withOpacity(0.5),
      title: Text(event.name),
      subtitle: Text(event.date.toString().split(' ')[0]),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EventPage(event);
        }));
      },
    ),
  );
}

Widget eventList(BuildContext context, List<Event> upcomingEvents) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Text('Upcoming Events: ${upcomingEvents.length}'),
          const SizedBox(
            height: 10,
          ),
          for (var event in upcomingEvents) eventCard(event, context),
        ],
      ),
    ),
  );
}

Widget eventCalendar(BuildContext context, List<Event> events) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: es.EventCalendar(
      calendarType: es.CalendarType.GREGORIAN,
      calendarOptions: es.CalendarOptions(
        headerMonthBackColor: Colors.white30,
        bottomSheetBackColor: Colors.white
      ),
        dayOptions:es.DayOptions(
          unselectedTextColor: Colors.white
        ),
      eventOptions: es.EventOptions(
        emptyTextColor: Colors.white
      ),
      events: [
        for (Event e in events)
          es.Event(
            child: eventCard(e, context),
            dateTime: es.CalendarDateTime(
              year: e.date.year,
              month: e.date.month,
              day: e.date.day,
              calendarType: es.CalendarType.GREGORIAN,
            ),
          ),
      ],
    ),
  );
}

Widget eventMap(BuildContext context, List<Event> events) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(7.75, 80.75),
        zoom: 7.75,
      ),
      markers: {
        for (Event e in events)
          Marker(
            markerId: MarkerId(e.name),
            position: LatLng(
              e.location?.latitude ?? 0.0,
              e.location?.longitude ?? 0.0,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EventPage(e);
              }));
            },
          ),
      },
    ),
  );
}

Widget pastEvents(
    BuildContext context, List<Event> events, List<Event> upcomingEvents) {
  List<Event> pastEvents = [];
  for (var element in events) {
    if (!upcomingEvents.contains(element)) {
      pastEvents.add(element);
    }
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          // Text('Past Events: ${pastEvents.length}'),
          const SizedBox(
            height: 10,
          ),
          for (var event in pastEvents) eventCard(event, context),
        ],
      ),
    ),
  );
}
