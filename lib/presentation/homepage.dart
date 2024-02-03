import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festiva/presentation/add_event.dart';
import 'package:festiva/presentation/components.dart';
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
  List<Event> events = [], upcomingEvents = [],items=[];
  int currentIndex = 0;

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

  Future<List<Event>> getItems() async {
    List<Event> eventList = [];

    final evnts = await _firestore.collection('items').get();
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
    loadItems();
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

  Future<void> loadItems() async {
    List<Event> fetchedEvents = await getItems();
    fetchedEvents.sort((a, b) => a.date.compareTo(b.date));

    setState(() {
      items = fetchedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Festiva',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Events'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.phone_android), label: 'Items'),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: [
        eventList(context, upcomingEvents),
        eventCalendar(context, events),
        eventMap(context, events),
        pastEvents(context, events, upcomingEvents),
        itemList(context,items)
      ][currentIndex],
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
        },
      ),
    );
  }
}
