import 'package:festiva/utility/event.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  const EventPage(this.event, {super.key});
  final Event event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.event.media.isEmpty);
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.event.name),
            Text(widget.event.date.toString().split(' ')[0]),
            widget.event.media.isEmpty
                ? const SizedBox()
                : CarouselSlider(
                    options: CarouselOptions(height: 400.0),
                    items: widget.event.media.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(i);
                        },
                      );
                    }).toList(),
                  ),
            Text(widget.event.description),
            widget.event.location==null?const SizedBox():
            SizedBox(
              height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.event.location?.latitude ?? 0.0,
                  widget.event.location?.longitude ?? 0.0,
                ),
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId(''),
                  position: LatLng(
                    widget.event.location?.latitude ?? 0.0,
                    widget.event.location?.longitude ?? 0.0,
                  ),
                ),
              },
            ),
            ),
            Text(widget.event.publisherName),
            IconButton(
                onPressed: ()async{
                  await launch(widget.event.publisherLink);
                },
              icon: const Icon(Icons.open_in_new),
            ),
          ],
        ),
      ),
    );
  }
}
