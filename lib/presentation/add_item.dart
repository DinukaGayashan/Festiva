import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festiva/utility/event.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:uuid/uuid.dart';

class AddItem extends StatefulWidget {
  const AddItem(this.events, {super.key});

  final List<Event> events;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  late String itemName = '', description = '';
  DateTime date = DateTime.now();
  FilePickerResult? media;
  late GeoPoint? location = null;
  late String publisherName = '', publisherLink = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Item name'),
              TextField(
                onChanged: (value) {
                  itemName = value;
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
              SizedBox(
                width: 140,
                child: FilledButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
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
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Media'),
              SizedBox(
                width: 140,
                child: FilledButton(
                  child: Text(media?.count != null
                      ? '${media?.count} selected'
                      : '0 selected'),
                  onPressed: () async {
                    media = await FilePicker.platform
                        .pickFiles(allowMultiple: true);
                    setState(() {
                      media;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Location'),
              SizedBox(
                width: 140,
                child: FilledButton(
                  child: const Text('Set Location'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: const Text('Select Location'),
                          ),
                          body: OpenStreetMapSearchAndPick(
                            center: const LatLong(6.927079, 79.861244),
                            buttonColor: Colors.blue.shade600,
                            buttonText: 'Set Location',
                            onPicked: (pickedData) {
                              location = GeoPoint(pickedData.latLong.latitude,
                                  pickedData.latLong.longitude);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () async {
                    if (itemName.isEmpty || description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Please add item details.')));
                    } else {
                      try {
                        final LoginResult loginResult =
                            await FacebookAuth.instance.login(
                          permissions: ['public_profile', 'user_link'],
                        );
                        if (loginResult.status == LoginStatus.success) {
                          final userData = await FacebookAuth.i.getUserData(
                            fields: "name,email,picture.width(200),link",
                          );
                          publisherName = userData['name'];
                          publisherLink = userData['link'];

                          List<String> medias = [];
                          var uuid = const Uuid();
                          final media = this.media;
                          if (media != null) {
                            for (PlatformFile file in media.files) {
                              UploadTask uploadTask;
                              String path = 'media/$itemName/${uuid.v4()}';
                              uploadTask = _storage
                                  .ref()
                                  .child(path)
                                  .putFile(File(file.path!));

                              final snapshot =
                              await uploadTask.whenComplete(() {});
                              final url = await snapshot.ref.getDownloadURL();
                              medias.add(url);
                            }
                          }

                          await _firestore.collection('items').add({
                            'eventName': itemName,
                            'description': description,
                            'date': date,
                            'media': medias,
                            'location': location,
                            'publisherName': publisherName,
                            'publisherLink': publisherLink,
                          });

                          Event newEvent = Event(itemName, description, date,
                              medias, location, publisherName, publisherLink);
                          widget.events.add(newEvent);
                          // widget.upcomingEvents.add(newEvent);
                          // widget.upcomingEvents.sort((a, b) => a.date.compareTo(b.date));

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Item successfully added.')));
                          Navigator.pop(context);
                        }

                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('User login failed.')));
                      }
                    }
                  },
                  child: const Text('Add item'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
