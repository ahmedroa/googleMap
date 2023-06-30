import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappp/constants/my_colors.dart';
import 'package:mappp/helper/location_helper.dart';
import 'package:mappp/layout/widget/myDrawer.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  final phoneNumber;
  const MapScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  Set<Marker> markers = Set();

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: markers,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  //

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: MyColors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      // progress: progressIndicator,
      onQueryChanged: (query) {
        // getPlacesSuggestions(query);
      },
      onFocusChanged: (_) {
        // hide distance and time row
        setState(() {
          // isTimeAndDistanceVisible = false;
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)), onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // buildSuggestionsBloc(),
              // buildSelectedPlaceLocationBloc(),
              // buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
  }

  // void addMarkerToMarkersAndUpdateUI(Marker marker) {
  //   setState(() {
  //     markers.add(marker);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: MyColors.blue,
                    ),
                  ),
                ),
          buildFloatingSearchBar(),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: MyColors.blue,
          onPressed: _goToMyCurrentLocation,
          child: Icon(Icons.place, color: Colors.white),
        ),
      ),
    );
  }
}
