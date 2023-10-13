import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  late String name;
  late String description;
  late DateTime date;
  late List<dynamic> media;
  late GeoPoint? location;
  late String publisherName;
  late String publisherLink;

  Event(this.name, this.description, this.date, this.media, this.location, this.publisherName, this.publisherLink);
}