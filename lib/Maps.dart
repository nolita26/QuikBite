import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesSearchMapSample extends StatefulWidget {
  final String keyword;
  PlacesSearchMapSample(this.keyword);

  @override
  State<PlacesSearchMapSample> createState() {
    return _PlacesSearchMapSample();
  }
}

class _PlacesSearchMapSample extends State<PlacesSearchMapSample> {
  static const String _API_KEY = 'AIzaSyAIFCtkfQICnpKwRiHWbryLqQ-Sb2RVOIA';

  static double latitude = 19.076090;
  static double longitude = 72.877426;
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

  List<Marker> markers = <Marker>[];
  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;

  Completer<GoogleMapController> _controller = Completer();


  static final CameraPosition _myLocation = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 12,
      bearing: 15.0,
      tilt: 75.0
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _myLocation,
        onMapCreated: (GoogleMapController controller) {
          _setStyle(controller);
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          searchNearby(latitude, longitude);
        },
        label: Text('Places Nearby'),
        icon: Icon(Icons.place),
      ),
    );
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context).loadString('assets/maps_style.json');
    controller.setMapStyle(value);
  }

  void searchNearby(double latitude, double longitude) async {
    setState(() {
      markers.clear();
    });
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=supermarket';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data){
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {},
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }
}

class Error {
  final String errorMessage;
  final List<dynamic> htmlAttributions;
  final List<dynamic> results;
  final String status;

  String getErrorMessage() {
    return errorMessage;
  }

  Error({this.errorMessage, this.htmlAttributions, this.results, this.status});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      errorMessage: json['error_message'],
      htmlAttributions: json['html_attributions'],
      results: json['results'],
      status: json['status'],
    );
  }
}

class Geometry {
  final Location location;
  final ViewPort viewPort;
  Geometry({this.location, this.viewPort});

  factory Geometry.fromJson(Map<String, dynamic> json){
    return Geometry(
        location: Location.fromJson(json['location']),
        viewPort: ViewPort.fromJson(json['viewport'])
    );
  }
}

class Location {
  final double lat;
  final double long;
  Location({this.lat, this.long});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
        lat: json['lat'],
        long: json['lng']
    );
  }
}

class Photo {
  int height;
  int width;
  List<String> htmlAttributions;
  String photoReference;

  Photo({this.height, this.width, this.htmlAttributions, this.photoReference});

  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
        height: json['height'],
        width: json['width'],
        htmlAttributions: List<String>.from(json['html_attributions']),
        photoReference: json['photo_reference']
    );
  }
}

class PlaceResponse {
  final List<String> htmlAttributions;
  final List<Result> results;
  final String status;
  final String nextPageToken;

  PlaceResponse({this.htmlAttributions, this.results, this.status, this.nextPageToken});

  PlaceResponse fromJson(Map<String, dynamic> json) {
    return PlaceResponse(
        htmlAttributions: List<String>.from(json['html_attributions']),
        nextPageToken: json['next_page_token'],
        results: parseResults(json['results']),
        status: json['status']);
  }

  static List<Result> parseResults(List<dynamic> list){
    return list.map((i) => Result.fromJson(i)).toList();
  }
}

class Result {
  final Geometry geometry;
  final String icon;
  final String id;
  final String name;
  final List<Photo> photos;
  final String placeId;
  final double rating;
  final String reference;
  final String scope;
  final List<String> types;
  final int userRatingsTotal;
  final String vicinity;

  Result({this.geometry, this.icon, this.id, this.name, this.placeId, this.reference,
    this.scope, this.vicinity, this.types, this.photos,
    this.userRatingsTotal, this.rating});

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      geometry: Geometry.fromJson(json['geometry']),
      icon: json['icon'],
      id: json['id'],
      name: json['name'],
      photos: json['photos'] != null ? json['photos'].map<Photo>((i) => Photo.fromJson(i)).toList(): [],
      placeId: json['place_id'],
      rating: json['rating'] != null ? json['rating'].toDouble(): 0.0,
      reference: json['reference'],
      scope: json['scope'],
      types: List<String>.from(json['types']),
      userRatingsTotal: json['user_ratings_total'],
      vicinity: json['vicinity'],
    );
  }
}

class ViewPort {
  final Location northEast;
  final Location southWest;
  ViewPort({this.northEast, this.southWest});

  factory ViewPort.fromJson(Map<String, dynamic> json){
    return ViewPort(
        northEast: Location.fromJson(json['northeast']),
        southWest: Location.fromJson(json['southwest'])
    );
  }
}
