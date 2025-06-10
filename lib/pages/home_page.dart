import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_now/pages/profile.dart';
import 'weather_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String? _selectedCity;
  final List<String> _cities = ['Delhi', 'Mumbai', 'Bengaluru', 'Kolkata', 'Chennai', 'Hyderabad'];

  void _navigateToWeather(String city) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherPage(city: city)),
    );
  }

  Future<void> _getCurrentLocationCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;
    if (city != null) _navigateToWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Important for proper header rendering
          children: [
            SizedBox(
              height: 110,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Welcome to WeatherNow!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Center(child: Text('WeatherNow 🌦️')),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text input
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _navigateToWeather(_controller.text.trim());
                  }
                },
                child: const Text('🔍 Search'),
              ),

              const Divider(height: 30),
              const SizedBox(height: 100),
              // Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCity,
                hint: const Text("Select from dropdown"),
                items: _cities
                    .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                    if (value != null) _navigateToWeather(value);
                  });
                },
              ),

              const Divider(height: 30),

              // Quick Tap Buttons
              const Text("Major Cities", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: _cities
                    .map((city) => ElevatedButton(
                  onPressed: () => _navigateToWeather(city),
                  child: Text(city),
                ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Current Location
              ElevatedButton.icon(
                onPressed: _getCurrentLocationCity,
                icon: const Icon(Icons.my_location),
                label: const Text("Use My Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
