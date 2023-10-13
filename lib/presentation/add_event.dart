import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});
  static const String id = 'AddEvent';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTimeRange range =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event name'),
            TextField(
              style: const TextStyle(
                fontSize: 20,
              ),
              onTap: (() {}),
              onChanged: (value) {},
            ),
            const Text('Description'),
            TextField(
              maxLines: 100000,
              minLines: 10,
              style: const TextStyle(
                fontSize: 15,
              ),
              onTap: (() {}),
              onChanged: (value) {},
            ),
            const Text('Date'),
            Text(
                '${range.start.year}/${range.start.month}/${range.start.day} to ${range.end.year}/${range.end.month}/${range.end.day}'),
            MaterialButton(
                child: const Text('Select Dates'),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000),
                      initialDate: DateTime.now()
                  );
                }),
            const Text('Media'),

            const Text('Location'),
            SizedBox(
              height: 200,
              // child: GoogleMap(
              //   initialCameraPosition: const CameraPosition(
              //     target: LatLng(-33.86, 151.20),
              //     zoom: 11.0,
              //   ),
              //   markers: {
              //     const Marker(
              //       markerId: MarkerId('Sydney'),
              //       position: LatLng(-33.86, 151.20),
              //     )
              //   },
              // ),
            ),
            const Text('Publisher Details'),
            const Text('Name'),
            TextField(
              style: const TextStyle(
                fontSize: 10,
              ),
              onTap: (() {}),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
