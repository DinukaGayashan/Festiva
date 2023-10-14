import 'package:festiva/presentation/event_page.dart';
import 'package:festiva/utility/event.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget eventCard(Event event, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      tileColor: kTransparentColor1,
      title: Text(event.name),
      subtitle: Text(event.date.toString().split(' ')[0]),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EventPage(event);
        }));
      },
    ),
  );
}