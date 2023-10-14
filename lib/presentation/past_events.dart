import 'package:flutter/material.dart';

import '../utility/components.dart';
import '../utility/event.dart';

class PastEvents extends StatelessWidget {
  const PastEvents(this.events,this.upcomingEvents,{super.key});
  final List<Event> events;
  final List<Event> upcomingEvents;

  @override
  Widget build(BuildContext context) {

    List<Event> pastEvents=[];
    for (var element in events) {
      if(!upcomingEvents.contains(element)){
        pastEvents.add(element);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Events'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var event in pastEvents) eventCard(event, context),
          ],
        ),
      ),
    );
  }
}
