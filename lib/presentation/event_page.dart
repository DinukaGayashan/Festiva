import 'package:carousel_slider/carousel_slider.dart';
import 'package:festiva/utility/event.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.name,
                style: const TextStyle(
                  fontSize: 35,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.event.date.toString().split(' ')[0],
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.event.media.isEmpty
                  ? const SizedBox()
                  : CarouselSlider(
                      options: CarouselOptions(
                          height: 250.0,
                          aspectRatio:4/3,
                          viewportFraction:0.95,
                      ),
                      items: widget.event.media.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(i);
                          },
                        );
                      }).toList(),
                    ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.event.description,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 40,
              ),
              widget.event.location == null
                  ? const SizedBox()
                  : SizedBox(
                      height: 150,
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
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                child: Row(
                  children: [
                    const Icon(
                      Icons.facebook,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.event.publisherName,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onPressed: () async {
                  await launch(widget.event.publisherLink);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
