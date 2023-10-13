import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festiva/presentation/add_event.dart';
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
  List<Event> events=[];

  Future<List<Event>> getEvents() async {
    List<Event> eventList = [];
    final evnts = await _firestore
        .collection('events')
        .get();
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
    setState(() {
      events = fetchedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Festiva'),
        ),
      body: Column(
        children: <Widget>[
          Text('Total Events: ${events.length}'),
          for (var event in events)
            ListTile(title: Text(event.name),)
        ],
      ),

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, AddEvent.id);
          },
      ),
    );
  }
}
