import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festiva/presentation/add_event.dart';
import 'package:festiva/presentation/event_calendar.dart';
import 'package:festiva/utility/components.dart';
import 'package:festiva/utility/constants.dart';
import 'package:festiva/utility/event.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = FirebaseFirestore.instance;
  List<Event> events = [], upcomingEvents = [];

  Future<List<Event>> getEvents() async {
    List<Event> eventList = [];
    final evnts = await _firestore.collection('events').get();
    for (var event in evnts.docs) {
      eventList.add(Event(
        event.data()['eventName'],
        event.data()['description'],
        event.data()['date'].toDate(),
        event.data()['media'],
        event.data()['location'],
        event.data()['publisherName'],
        event.data()['publisherLink'],
      ));
    }
    return eventList;
  }

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    List<Event> fetchedEvents = await getEvents();
    fetchedEvents.sort((a, b) => a.date.compareTo(b.date));
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    upcomingEvents =
        fetchedEvents.where((event) => event.date.isAfter(yesterday)).toList();
    setState(() {
      events = fetchedEvents;
      upcomingEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festiva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Text('Total Events: ${events.length}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: MaterialButton(
                    color: kAccentColor2,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EventCalendarPage(events);
                      }));
                    },
                    child: const Text('Event Calendar'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: MaterialButton(
                    color: kAccentColor2,
                    onPressed: () {},
                    child: const Text('Event Map'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: MaterialButton(
                    color: kAccentColor2,
                    onPressed: () {},
                    child: const Text('Search Events'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: MaterialButton(
                    color: kAccentColor2,
                    onPressed: () {},
                    child: const Text('Past Events'),
                  ),
                ),
              ],
            ),
            Text('Upcoming Events: ${upcomingEvents.length}'),
            for (var event in upcomingEvents) eventCard(event, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddEvent(events, upcomingEvents);
          })).then((_) {
            setState(() {
              events;
              upcomingEvents;
            });
          });
          // Navigator.pushNamed(context, AddEvent.id);
        },
      ),
    );
  }
}
