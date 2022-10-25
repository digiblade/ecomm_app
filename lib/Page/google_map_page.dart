import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Components/Button/solid_button.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Position? _currentLocation;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      zoom: 19.151926040649414);
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          print("No location found");
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final Uint8List? markerIcon =
          await getBytesFromAsset('assets/images/banner/pointer.png', 100);

      MarkerId markerId = const MarkerId("userlocation");
      final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: "templocation", snippet: '*'),
          icon: BitmapDescriptor.fromBytes(markerIcon!));
      setState(() {
        markers[markerId] = marker;
      });
      setState(() {
        _currentLocation = position;
        print("current Location is $_currentLocation");
      });
      CameraPosition currentCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18.0,
      );
      final GoogleMapController controller = await _controller.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
    } catch (e) {
      // ignore: avoid_print
      print("error: $e");
    }
  }

  Future<void> _goToTheLake() async {
    final Uint8List? markerIcon =
        await getBytesFromAsset('assets/images/banner/deliveryicon.png', 100);

    MarkerId markerId = const MarkerId("templocation");
    final Marker marker = Marker(
        markerId: markerId,
        position: _kLake.target,
        infoWindow: const InfoWindow(title: "templocation", snippet: '*'),
        icon: BitmapDescriptor.fromBytes(markerIcon!));
    setState(() {
      markers[markerId] = marker;
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  getRoute() async {
    Position startPlacemark = _currentLocation!;
    LatLng destinationPlacemark = _kLake.target;

// Storing latitude & longitude of start and destination location
    double startLatitude = startPlacemark.latitude;
    double startLongitude = startPlacemark.longitude;
    double destinationLatitude = destinationPlacemark.latitude;
    double destinationLongitude = destinationPlacemark.longitude;

    double miny = (startLatitude <= destinationLatitude)
        ? startLatitude
        : destinationLatitude;
    double minx = (startLongitude <= destinationLongitude)
        ? startLongitude
        : destinationLongitude;
    double maxy = (startLatitude <= destinationLatitude)
        ? destinationLatitude
        : startLatitude;
    double maxx = (startLongitude <= destinationLongitude)
        ? destinationLongitude
        : startLongitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;
    _createPolylines(startLatitude, startLongitude, destinationLatitude,
        destinationLongitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
  }

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCAKNL-W1hPdPR5mZJfsL1n3bBqy0xiIdw", // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );
    debugger();
    List<LatLng> polylineCoordinates = [];
    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
              ),
            ),
            SolidButton(
              onPressed: _getCurrentLocation,
              label: "get current location",
            ),
            SolidButton(
              onPressed: _goToTheLake,
              label: "goToLake",
            ),
            SolidButton(
              onPressed: getRoute,
              label: "draw routes",
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getCurrentLocation,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
}
