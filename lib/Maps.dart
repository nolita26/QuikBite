// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
//
// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }
//
// class _MapsState extends State<Maps> {
//   static const Lat = 19.076090;
//   static const Lng = 72.877426;
//   static const apiKey = 'AIzaSyAIFCtkfQICnpKwRiHWbryLqQ-Sb2RVOIA';
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();
//     print(await searchNearBy('bagel'));
//   }
//
//   Future<List<String>> searchNearBy(String keyword) async {
//     var dio = Dio();
//     var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
//     var parameters = {
//       'key': apiKey;
//       'location': '$Lat, $Lng',
//       'radius': '800',
//       'keyword': keyword,
//     };
//
//     var response = await dio.get(url, data: parameters);
//     return response.data['results'].map<String>((result) => result['name'].toString()).toList();
//   }
// }
