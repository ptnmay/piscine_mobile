import 'package:flutter/material.dart';

class Ex00 extends StatefulWidget {
  const Ex00({super.key});

  @override
  State<Ex00> createState() => _Ex00State();
}

class _Ex00State extends State<Ex00> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const textColor = Color.fromARGB(255, 0, 54, 105);
  static const pinkWater = Color.fromARGB(255, 237, 174, 192);
  static const turquoise = Color.fromARGB(255, 48, 213, 200);
  static const spearmint = Color.fromARGB(255, 69, 176, 140);
  static const peach = Color.fromARGB(255, 255, 229, 180);

  final List<Tab> tabs = const [
    Tab(icon: Icon(Icons.wb_sunny), text: 'Currently'),
    Tab(icon: Icon(Icons.today), text: 'Today'),
    Tab(icon: Icon(Icons.calendar_view_week), text: 'Weekly'),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _displayText = ''; // Dynamic part to display in tabs

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    setState(() {
      _displayText = _searchController.text.trim();
    });
  }

  void _onGeolocation() {
    setState(() {
      _displayText = 'Geolocation';
    });
  }

  Widget _buildTabContent(String label) {
    return Center(
      child: Text(
        '$label \n ${_displayText.isEmpty ? "" : _displayText}',
        style: const TextStyle(fontSize: 24, color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: turquoise,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        toolbarHeight: 100,
        backgroundColor: pinkWater,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: (_) => _onSearch(),
                decoration: InputDecoration(
                  hintText: 'Search city...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: peach,
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _onSearch,
            ),
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: _onGeolocation,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('Currently'),
          _buildTabContent('Today'),
          _buildTabContent('Weekly'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: pinkWater,
        child: TabBar(
          controller: _tabController,
          tabs: tabs,
          labelColor: peach,
          unselectedLabelColor: spearmint,
          indicatorColor: peach,
        ),
      ),
    );
  }
}
