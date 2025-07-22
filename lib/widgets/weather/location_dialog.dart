import 'package:flutter/material.dart';
import '../../services/location_service.dart';

class LocationDialog extends StatefulWidget {
  final Function(String) onLocationSelected;

  const LocationDialog({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  final TextEditingController _cityController = TextEditingController();
  bool _isGettingLocation = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Location'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: _isGettingLocation
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            title: const Text('Use Current Location'),
            subtitle: const Text('Get weather for your current location'),
            onTap: _isGettingLocation ? null : _useCurrentLocation,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                hintText: 'e.g., San Francisco, CA',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onLocationSelected(value);
                  Navigator.pop(context);
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final city = _cityController.text.trim();
                if (city.isNotEmpty) {
                  widget.onLocationSelected(city);
                  Navigator.pop(context);
                }
              },
              child: const Text('Set Location'),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Popular Locations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildPopularLocationsList(),
        ],
      ),
    );
  }

  Widget _buildPopularLocationsList() {
    final popularCities = [
      'San Francisco, CA',
      'Los Angeles, CA',
      'New York, NY',
      'Chicago, IL',
      'Miami, FL',
      'Seattle, WA',
    ];

    return Column(
      children: popularCities
          .map((city) => ListTile(
                dense: true,
                leading: const Icon(Icons.location_city, size: 20),
                title: Text(
                  city,
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () {
                  widget.onLocationSelected(city);
                  Navigator.pop(context);
                },
              ))
          .toList(),
    );
  }

  void _useCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      final hasPermission = await LocationService.checkLocationPermission();
      if (hasPermission) {
        widget.onLocationSelected('current_location');
        Navigator.pop(context);
      } else {
        _showLocationPermissionError();
      }
    } catch (e) {
      _showLocationError();
    } finally {
      if (mounted) {
        setState(() {
          _isGettingLocation = false;
        });
      }
    }
  }

  void _showLocationPermissionError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Location permission is required to use current location'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showLocationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to get current location. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
