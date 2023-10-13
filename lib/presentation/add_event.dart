import 'package:festiva/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:gallery_picker/gallery_picker.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});
  static const String id = 'AddEvent';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late String eventName = '', description = '';
  DateTime date = DateTime.now();
  List<MediaFile>? media;
  late LatLong? location;
  late String publisherName = '', publisherLink = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Event name'),
              TextField(
                onChanged: (value) {
                  eventName = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Description'),
              TextField(
                maxLines: 1000,
                minLines: 5,
                onChanged: (value) {
                  description = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Date'),
              MaterialButton(
                color: kAccentColor2,
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000),
                    initialDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      date = DateTime(selectedDate.year, selectedDate.month,
                          selectedDate.day);
                    }
                  });
                  setState(() {
                    date;
                  });
                },
                child: Text('${date.year}/${date.month}/${date.day}'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Media'),
              MaterialButton(
                color: kAccentColor2,
                child: Text(media?.length != null
                    ? '${media?.length} selected'
                    : '0 selected'),
                onPressed: () async {
                  media = await GalleryPicker.pickMedia(context: context);
                  setState(() {
                    media;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Location'),
              MaterialButton(
                color: kAccentColor2,
                child: const Text('Set Location'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: OpenStreetMapSearchAndPick(
                            center: const LatLong(6.927079, 79.861244),
                            buttonColor: kBackgroundColor,
                            buttonText: 'Set Location',
                            onPicked: (pickedData) {
                              location = pickedData.latLong;
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              // SizedBox(
              //   height: 200,
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
              // ),
              const SizedBox(
                height: 40,
              ),
              const Text('Publisher Details'),
              const SizedBox(
                height: 20,
              ),
              const Text('Name'),
              TextField(
                onChanged: (value) {
                  publisherName = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Social Link'),
              TextField(
                onChanged: (value) {
                  publisherLink = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              MaterialButton(
                color: kAccentColor1,
                onPressed: () {
                  if (eventName.isEmpty || description.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please add necessary event details.')));
                  } else if (publisherName.isEmpty || publisherLink.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please add necessary user details.')));
                  } else {
                    print(date);
                    print(media?.length);
                    print(location);
                  }
                },
                child: const Text('           Add event            '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
