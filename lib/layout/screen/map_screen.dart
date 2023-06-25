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

  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

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
      // polylines: placeDirections != null
      // ? {
      //     Polyline(
      //       polylineId: const PolylineId('my_polyline'),
      //       color: Colors.black,
      //       width: 2,
      //       points: polylinePoints,
      //     ),
      //   }
      // : {},
    );
  }

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  // void buildCameraNewPosition() {
  //   goToSearchedForPlace = CameraPosition(
  //     bearing: 0.0,
  //     tilt: 0.0,
  //     target: LatLng(
  //       selectedPlace.result.geometry.location.lat,
  //       selectedPlace.result.geometry.location.lng,
  //     ),
  //     zoom: 13,
  //   );
  // }

  // these variables for getDirections
  // PlaceDirections? placeDirections;
  // var progressIndicator = false;
  // late List<LatLng> polylinePoints;
  // var isSearchedPlaceMarkerClicked = false;
  // var isTimeAndDistanceVisible = false;
  // late String time;
  // late String distance;

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

  // Widget buildDiretionsBloc() {
  //   return BlocListener<MapsCubit, MapsState>(
  //     listener: (context, state) {
  //       if (state is DirectionsLoaded) {
  //         placeDirections = (state).placeDirections;

  //         getPolylinePoints();
  //       }
  //     },
  //     child: Container(),
  //   );
  // }

  // void getPolylinePoints() {
  //   polylinePoints = placeDirections!.polylinePoints
  //       .map((e) => LatLng(e.latitude, e.longitude))
  //       .toList();
  // }

  // Widget buildSelectedPlaceLocationBloc() {
  //   return BlocListener<MapsCubit, MapsState>(
  //     listener: (context, state) {
  //       if (state is PlaceLocationLoaded) {
  //         selectedPlace = (state).place;

  //         goToMySearchedForLocation();
  //         getDirections();
  //       }
  //     },
  //     child: Container(),
  //   );
  // }

  // void buildCurrentLocationMarker() {
  //   currentLocationMarker = Marker(
  //     position: LatLng(position!.latitude, position!.longitude),
  //     markerId: MarkerId('2'),
  //     onTap: () {},
  //     infoWindow: InfoWindow(title: "Your current Location"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //   );
  //   addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  // }

  // void addMarkerToMarkersAndUpdateUI(Marker marker) {
  //   setState(() {
  //     markers.add(marker);
  //   });
  // }

  // void getPlacesSuggestions(String query) {
  //   final sessionToken = Uuid().v4();
  //   BlocProvider.of<MapsCubit>(context)
  //       .emitPlaceSuggestions(query, sessionToken);
  // }

  // Widget buildSuggestionsBloc() {
  //   return BlocBuilder<MapsCubit, MapsState>(
  //     builder: (context, state) {
  //       if (state is PlacesLoaded) {
  //         places = (state).places;
  //         if (places.length != 0) {
  //           return buildPlacesList();
  //         } else {
  //           return Container();
  //         }
  //       } else {
  //         return Container();
  //       }
  //     },
  //   );
  // }

  // Widget buildPlacesList() {
  //   return ListView.builder(
  //       itemBuilder: (ctx, index) {
  //         return InkWell(
  //           onTap: () async {
  //             placeSuggestion = places[index];
  //             controller.close();
  //             getSelectedPlaceLocation();
  //             polylinePoints.clear();
  //              removeAllMarkersAndUpdateUI();
  //           },
  //           child: PlaceItem(
  //             suggestion: places[index],
  //           ),
  //         );
  //       },
  //       itemCount: places.length,
  //       shrinkWrap: true,
  //       physics: const ClampingScrollPhysics());
  // }

  // void removeAllMarkersAndUpdateUI() {
  //   setState(() {
  //     markers.clear();
  //   });
  // }

  // void getSelectedPlaceLocation() {
  //   final sessionToken = Uuid().v4();
  //   BlocProvider.of<MapsCubit>(context)
  //       .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
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
