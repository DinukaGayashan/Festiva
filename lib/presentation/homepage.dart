import 'package:festiva/presentation/add_event.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    // const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Festiva'),
          // notificationPredicate: (ScrollNotification notification) {
          //   return notification.depth == 1;
          // },
          // scrolledUnderElevation: 4.0,
          // shadowColor: Theme.of(context).shadowColor,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.event_available),
                text: 'Events',
              ),
              Tab(
                icon: Icon(Icons.calendar_month),
                text: 'Calendar',
              ),
              Tab(
                icon: Icon(Icons.map),
                text: 'Map',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[

          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, AddEvent.id);
          },
        ),
      ),
    );
  }
}
