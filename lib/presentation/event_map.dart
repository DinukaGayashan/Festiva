import 'package:festiva/presentation/event_page.dart';
import 'package:festiva/utility/event.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMapPage extends StatefulWidget {
  const EventMapPage(this.events, {super.key});
  final List<Event> events;

  @override
  State<EventMapPage> createState() => _EventMapPageState();
}

class _EventMapPageState extends State<EventMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(7.75, 80.75),
          zoom: 7.75,
        ),
        markers: {
          for (Event e in widget.events)
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
}
