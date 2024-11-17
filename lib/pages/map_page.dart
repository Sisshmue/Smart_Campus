import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_campus_mobile_app/const.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static const LatLng _pMsquare = LatLng(20.046588486327085, 99.89128965622983);
  static const LatLng _pD1Canteen =
      LatLng(20.047726253086168, 99.89377030087009);
  static LatLng _pE2Canteen = LatLng(20.04440572916637, 99.8936036907117);
  static LatLng _pC4Building = LatLng(20.04444071026857, 99.89478627661364);
  static LatLng _pC1Building = LatLng(20.045063973720612, 99.89549836049295);
  static LatLng _pC3Building = LatLng(20.044152941288306, 99.89535405015467);
  static LatLng _pC5Building = LatLng(20.042823327492613, 99.89509604162903);
  static LatLng _pM3Building = LatLng(20.042529178493556, 99.89419190820804);
  static LatLng _pBotGarden = LatLng(20.039654124289825, 99.89532519130199);
  static LatLng _pS7Building = LatLng(20.048282341941803, 99.8950751319836);
  LatLng? _currentP = null;
  Map<PolylineId, Polyline> polylines = {};
  TextEditingController _searchController = TextEditingController();

  bool _followUserLocation = true; // Flag to control camera follow behavior

  // Predefined locations with their coordinates
  final Map<String, LatLng> _locations = {
    "MSquare": _pMsquare,
    "D1 Food Court": _pD1Canteen,
    "E2 Food Court": _pE2Canteen,
    "C4 Building": _pC4Building,
    "C1 Building": _pC1Building,
    "C3 Building": _pC3Building,
    "C5 Building": _pC5Building,
    "M3 Building": _pM3Building,
    "Botanical Garden": _pBotGarden,
    "S7 Building": _pS7Building,
    // Add more locations as needed
  };

  // Store markers
  Map<MarkerId, Marker> markers = {};

  // List to hold filtered suggestions
  List<String> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) => {
          getPolyLinePoints().then((coordinates) => {
                generatePolyLineFromPoints(coordinates),
              })
        });
    _addMarkers(); // Add markers for predefined locations
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentP != null) {
            _cameraToPosition(_currentP!);
          }
        },
        child: Icon(Icons.my_location),
      ),
      appBar: AppBar(
        title: Text('Map Guide'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterLocations,
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchLocation(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          // Use Expanded to control the height of the suggestion list
          _filteredLocations.isNotEmpty
              ? Expanded(
                  flex: 0, // Ensures it only takes the space it needs
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredLocations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredLocations[index]),
                        onTap: () {
                          _searchLocation(_filteredLocations[index]);
                          _searchController.clear();
                          setState(() {
                            _filteredLocations.clear();
                          });
                        },
                      );
                    },
                  ),
                )
              : Container(),
          // Map display
          Expanded(
            child: _currentP == null
                ? Center(child: CircularProgressIndicator())
                : SizedBox.expand(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _pMsquare,
                        zoom: 13,
                      ),
                      onMapCreated: ((GoogleMapController controller) =>
                          _mapController.complete(controller)),
                      markers: Set<Marker>.of(markers.values),
                      polylines: Set<Polyline>.of(polylines.values),
                      onCameraMove: (CameraPosition position) {
                        // If the camera is moving manually, stop following the user's location
                        if (_followUserLocation) {
                          setState(() {
                            _followUserLocation = false;
                          });
                        }
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _filterLocations(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredLocations.clear();
      });
      return;
    }

    List<String> suggestions = _locations.keys
        .where((location) =>
            location.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredLocations = suggestions;
    });
  }

  Future<void> _searchLocation(String query) async {
    if (_locations.containsKey(query)) {
      LatLng destination = _locations[query]!;
      _cameraToPosition(destination);
      if (_currentP != null) {
        // Fetch and display the route from the current location to the destination
        await getDirections(_currentP!, destination);
      }
    } else {
      print('Location not found');
    }
  }

  Future<void> getDirections(LatLng start, LatLng end) async {
    // Initialize the PolylinePoints instance
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> routeCoords = [];

    // Get the list of points from start to end using PolylinePoints
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey:
          Google_Maps_API_Key, // Replace with your Google Maps API Key
      request: PolylineRequest(
          origin: PointLatLng(start.latitude, start.longitude),
          destination: PointLatLng(end.latitude, end.longitude),
          mode: TravelMode.walking),
    );

    if (result.points.isNotEmpty) {
      // Add each point to the route coordinates
      result.points.forEach((PointLatLng point) {
        routeCoords.add(LatLng(point.latitude, point.longitude));
      });

      // Draw the polyline on the map
      generatePolyLineFromPoints(routeCoords);
    } else {
      print('No route found');
    }
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 17);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location services are enabled
    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        print('Location services are not enabled');
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location permission denied');
        return;
      }
    }

    // Start listening to location changes
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          // Update the current location marker
          _addCurrentLocationMarker(_currentP!);
          // Move the camera to the current location if the flag is true
          if (_followUserLocation) {
            _cameraToPosition(_currentP!);
          }
        });
      }
    });
  }

  Future<void> _addMarkers() async {
    for (var entry in _locations.entries) {
      String locationName = entry.key;
      LatLng locationCoords = entry.value;

      MarkerId markerId = MarkerId(locationName);
      Marker marker = Marker(
        markerId: markerId,
        position: locationCoords,
        infoWindow: InfoWindow(
          title: locationName,
          snippet: 'Tap to view more',
        ),
      );

      setState(() {
        markers[markerId] = marker; // Add marker to the map
      });
    }
  }

  void _addCurrentLocationMarker(LatLng currentLocation) {
    MarkerId currentLocationMarkerId = MarkerId("current_location");
    Marker currentLocationMarker = Marker(
      markerId: currentLocationMarkerId,
      position: currentLocation,
      infoWindow: InfoWindow(
        title: "You are here",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue), // Optional: Change marker color
    );

    setState(() {
      markers[currentLocationMarkerId] =
          currentLocationMarker; // Update current location marker
    });
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    // Your logic to get polyline points
    // This is a placeholder; replace with your actual implementation
    return [];
  }

  void generatePolyLineFromPoints(List<LatLng> coordinates) {
    PolylineId id = PolylineId("route");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      width: 4,
      points: coordinates,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
