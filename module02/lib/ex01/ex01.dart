import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'color.dart';

class Ex01 extends StatefulWidget {
  const Ex01({super.key});

  @override
  State<Ex01> createState() => _Ex01State();
}

class _Ex01State extends State<Ex01> with SingleTickerProviderStateMixin {

  bool _locationDenied = false;
  String _displayText = '';
  
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

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
      if (_displayText.isNotEmpty) {
        _locationDenied = false;
      }
    });
  }

  void _onGeolocation() {
    _handleLocationPermission();
  }

  Future<void> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _displayText = 'Location permission denied.';
          _locationDenied = true;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _displayText = 'Location permission permanently denied.';
        _locationDenied = true;
      });
      return;
    }

    setState(() {
      _locationDenied = false;
    });

    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    try {
      final locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      setState(() {
        _displayText =
            'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _displayText = 'Failed to get location: $e';
      });
    }
  }

  Widget _buildTabContent(String label, bool locationDenied) {
    return Center(
      child: Text(
        locationDenied
            ? _displayText
            : '$label \n ${_displayText.isEmpty ? "" : _displayText}',
        style: TextStyle(
          fontSize: 24,
          color: locationDenied ? textDenied : textColor,
        ),
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
            IconButton(icon: const Icon(Icons.search), onPressed: _onSearch),
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
          _buildTabContent('Currently', _locationDenied),
          _buildTabContent('Today', _locationDenied),
          _buildTabContent('Weekly', _locationDenied),
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
