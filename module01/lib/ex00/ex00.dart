import 'package:flutter/material.dart';

class Ex00 extends StatelessWidget {
  const Ex00({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.location_pin),
                text: 'Currently'),
              Tab(
                icon: Icon(Icons.calendar_today),
                text: 'Today'),
              Tab(
                icon: Icon(Icons.calendar_view_week),
                text: 'Weekly'),
            ],
          ),
          title: const Text('ButtomBar'),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Color.fromARGB(255, 69, 176, 140),
              child: const Center(
                child: Text('Currently')),
            ),
            Container(
              color: Color.fromARGB(255, 237, 174, 192),
              child: const Center(
                child: Text('Today')),
            ),
            Container(
              color: Color.fromARGB(255, 48, 213, 200),
              child: const Center(
                child: Text('Weekly')),
            ),
          ],),
      ),
    );
  }
}
