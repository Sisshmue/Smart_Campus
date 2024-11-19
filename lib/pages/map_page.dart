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
  static LatLng _pS1Building = LatLng(20.045839788785713, 99.89435839080653);
  static LatLng _pMFUPond = LatLng(20.045028244753208, 99.89180600830913);
  static LatLng _pStatue = LatLng(20.045053199711184, 99.89410814868744);
  static LatLng _pPresident = LatLng(20.045046891369562, 99.89693989110751);
  static LatLng _pS5Building = LatLng(20.046614016891386, 99.89471785128319);
  static LatLng _pE1Building = LatLng(20.045869250844664, 99.89365286938717);

  static LatLng _pC2Building = LatLng(20.044107802613514, 99.89605148548654);
  static LatLng _pF2Dorm = LatLng(20.04858050701293, 99.89407580214458);
  static LatLng _pF3Dorm = LatLng(20.049671492285896, 99.89379877926693);
  static LatLng _pSakThong2 = LatLng(20.05030258110239, 99.89295777877017);
  static LatLng _pSakThong1 = LatLng(20.049965333070944, 99.8929764547121);
  static LatLng _pChineseDorm2 = LatLng(20.051655660469436, 99.8919036429642);
  static LatLng _pMuseum = LatLng(20.05242097452254, 99.89284084902377);
  static LatLng _pE3Building = LatLng(20.046295840595636, 99.89270244811303);
  static LatLng _pITSchool = LatLng(20.04644600022262, 99.89287070459947);
  static LatLng _pSwimmingPool = LatLng(20.05573276416445, 99.89494547315576);
  static LatLng _pIndoorStadium = LatLng(20.057043522778027, 99.89472847788038);
  static LatLng _pSportsComplex = LatLng(20.058726180669307, 99.89434501020905);
  static LatLng _pStadium = LatLng(20.05813089841835, 99.89625070186015);
  static LatLng _pWanawesResort = LatLng(20.055772574585077, 99.89783392882994);
  static LatLng _pL7Dorm = LatLng(20.05638050303439, 99.89752066868891);
  static LatLng _pL5Dorm = LatLng(20.05777522066765, 99.89781102181803);
  static LatLng _pL4Dorm = LatLng(20.058286999954397, 99.89835584708135);
  static LatLng _pL3Dorm = LatLng(20.05775704838566, 99.89866163288059);
  static LatLng _pL2Dorm = LatLng(20.058586787200532, 99.8990216664912);
  static LatLng _pL1Dorm = LatLng(20.057993261736208, 99.89904340323446);
  static LatLng _pWanasomResort = LatLng(20.05581727349741, 99.91150194553875);
  static LatLng _pDam = LatLng(20.05759103165572, 99.91528922461754);

  LatLng? _currentP = null;
  Map<PolylineId, Polyline> polylines = {};
  TextEditingController _searchController = TextEditingController();

  bool _followUserLocation = true; // Flag to control camera follow behavior
  // newly added
  final Map<String, String> _locationIcons = {
    "D1 Food Court": "icons/foodcourt.png",
    "E1 Food Court": "icons/foodcourt.png",
    "E2 Food Court": "icons/foodcourt.png",
    "MSquare": "icons/foodcourt.png",

    "Lamduan 3 Dormitory": "icons/maledorm.png",
    "Lamduan 2 Dormitory": "icons/maledorm.png",
    "Lamduan 1 Dormitory": "icons/maledorm.png",

    "F2 Dormitory": "icons/femaledorm.png",
    "F3 Dormitory": "icons/femaledorm.png",
    "SakThong 1 Dormitory": "icons/femaledorm.png",
    "SakThong 2 Dormitory": "icons/femaledorm.png",
    "Chinese 2 Dormitory": "icons/femaledorm.png",
    "Lamduan 4 Dormitory": "icons/femaledorm.png",
    "Lamduan 5 Dormitory": "icons/femaledorm.png",
    "Lamduan 6 Dormitory": "icons/femaledorm.png",
    "Lamduan 7 Dormitory": "icons/femaledorm.png",

    "E3 Building": "icons/class.png",
    "C1 Building": "icons/class.png",
    "C2 Building": "icons/class.png",
    "C3 Building": "icons/class.png",
    "C4 Building": "icons/class.png",
    "C5 Building": "icons/class.png",
    "M3 Building": "icons/class.png",
    "S1 Building": "icons/class.png",
    "S2 Building": "icons/class.png",
    "S5 Building": "icons/class.png",
    "S7 Building": "icons/class.png",

    "Botanical Garden": "icons/park.png",
    "MFU Pond": "icons/pond.png",
    "The Queen Mother Statue": "icons/statue.png",
    "MFU Dam": "icons/dam.png",
    "Mekong Basin Civilization Museum": "icons/museum.png",

    "Swimming Pool": "icons/pool.png",
    "Indoor Stadium": "icons/istadium.png",
    "Sports Complex": "icons/scomplex.png",
    "Stadium": "icons/ostadium.png",

    "School of Applied Digital Technology": "icons/office.png",

    // Add more locations with their corresponding icons
  };

  // Predefined locations with their coordinates
  final Map<String, LatLng> _locations = {
    "MSquare": _pMsquare,
    "D1 Food Court": _pD1Canteen,
    "E2 Food Court": _pE2Canteen,
    "E1 Food Court": _pE1Building,
    "C4 Building": _pC4Building,
    "C1 Building": _pC1Building,
    "C2 Building": _pC2Building,
    "C3 Building": _pC3Building,
    "C5 Building": _pC5Building,
    "M3 Building": _pM3Building,
    "Botanical Garden": _pBotGarden,
    "S7 Building": _pS7Building,
    "S1 Building": _pS1Building,
    "MFU Pond": _pMFUPond,
    "The Queen Mother Statue": _pStatue,
    "President Office, Mae Fah Luang University": _pPresident,
    "S5 Building": _pS5Building,
    "F2 Dormitory": _pF2Dorm,
    "F3 Dormitory": _pF3Dorm,
    "SakThong 1 Dormitory": _pSakThong1,
    "SakThong 2 Dormitory": _pSakThong2,
    "Chinese 2 Dormitory": _pChineseDorm2,
    "Mekong Basin Civilization Museum": _pMuseum,
    "E3 Building": _pE3Building,
    "School of Applied Digital Technology": _pITSchool,
    "Swimming Pool": _pSwimmingPool,
    "Indoor Stadium": _pIndoorStadium,
    "Sports Complex": _pSportsComplex,
    "Stadium": _pStadium,
    "Wanawes Resort": _pWanawesResort,
    "Lamduan 7 Dormitory": _pL7Dorm,
    "Lamduan 5 Dormitory": _pL5Dorm,
    "Lamduan 4 Dormitory": _pL4Dorm,
    "Lamduan 3 Dormitory": _pL3Dorm,
    "Lamduan 2 Dormitory": _pL2Dorm,
    "Lamduan 1 Dormitory": _pL1Dorm,
    "MFU Dam": _pDam,
    "Wanasom Resort": _pWanasomResort,
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
        title: Text(
          'Map Guide',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF67ab50),
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
                  flex: 1, // Ensures it only takes the space it needs
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

  // Future<void> _addMarkers() async {
  //   for (var entry in _locations.entries) {
  //     String locationName = entry.key;
  //     LatLng locationCoords = entry.value;
  //
  //     MarkerId markerId = MarkerId(locationName);
  //     Marker marker = Marker(
  //       markerId: markerId,
  //       position: locationCoords,
  //       infoWindow: InfoWindow(
  //         title: locationName,
  //         snippet: 'Tap to view more',
  //       ),
  //     );
  //
  //     setState(() {
  //       markers[markerId] = marker; // Add marker to the map
  //     });
  //   }
  // }

  //newly added
  Future<void> _addMarkers() async {
    for (var entry in _locations.entries) {
      String locationName = entry.key;
      LatLng locationCoords = entry.value;

      MarkerId markerId = MarkerId(locationName);

      // Load the appropriate icon
      BitmapDescriptor icon = await _getMarkerIcon(locationName);

      Marker marker = Marker(
        markerId: markerId,
        position: locationCoords,
        infoWindow: InfoWindow(
          title: locationName,
          snippet: 'Tap to view more',
        ),
        icon: icon, // Set the custom icon
      );

      setState(() {
        markers[markerId] = marker; // Add marker to the map
      });
    }
  }

  // Helper method to get the marker icon based on location name
  Future<BitmapDescriptor> _getMarkerIcon(String locationName) async {
    String iconPath = _locationIcons[locationName] ??
        "icons/location.png"; // Default icon if none found
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(38, 38)), // Adjust size as needed
      iconPath,
    );
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
          BitmapDescriptor.hueRed), // Optional: Change marker color
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
