import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {

  final double destinationLatitude ;
  final double destinationLongitude ;

  const MapPage({
    Key? key,
    required this.destinationLatitude,
    required this.destinationLongitude,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentLocation;
  bool _isFetchingLocation = true;

  @override
  void initState() {
    super.initState();
    print("Hello World");
    print("MapPage initialized with Latitude: ${widget.destinationLatitude}, Longitude: ${widget.destinationLongitude}");
    _fetchCurrentLocation();
  }

  // Fetch the user's current location
  Future<void> _fetchCurrentLocation() async {
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Handle denied permissions
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        setState(() {
          _isFetchingLocation = false;
        });
        return;
      }

      // Fetch the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isFetchingLocation = false;
      });
    } catch (e) {
      // Handle any errors
      setState(() {
        _isFetchingLocation = false;
      });
      debugPrint('Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' Map ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF8BB380),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isFetchingLocation
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          initialCenter: _currentLocation ??
              LatLng(widget.destinationLatitude, widget.destinationLongitude),
          initialZoom: 10.3,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              Marker( // Ensure this marker is correctly defined
                point: LatLng(
                  widget.destinationLatitude,
                  widget.destinationLongitude,
                ),
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



}