import 'package:flutter/material.dart';

import '../utility/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
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
      ),
    );
  }
}
