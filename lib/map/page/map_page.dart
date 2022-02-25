import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasty_punjab/map/model/hotel_info.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  GoogleMapController _mapController;

  LatLng _kMapCenter = LatLng(52.4478, -3.5402);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(52.4478, -3.5402),
    zoom: 14,
  );

  List<HotelInfo> hotelList = [
    HotelInfo(
        "Nexever food truck",
        'mohali',
        'https://nexever.org/TastyPunja/images/menu/1557734382_image_picker3613043629472866940.jpg',
        LatLng(52.4478, -3.5402)),
    HotelInfo(
        "Geekybones food truck",
        'mohali',
        'https://nexever.org/TastyPunja/images/menu/1557734382_image_picker3613043629472866940.jpg',
        LatLng(52.7, -3.7402)),
    HotelInfo(
        "REgalmojo food truck",
        'mohali',
        'https://nexever.org/TastyPunja/images/menu/1557734382_image_picker3613043629472866940.jpg',
        LatLng(52.78, -3.8402)),
    HotelInfo(
        "iApps food truck",
        'mohali',
        'https://nexever.org/TastyPunja/images/menu/1557734382_image_picker3613043629472866940.jpg',
        LatLng(52.9478, -3.4402)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Near by food track"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: createMarker(hotelList),
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            child: Container(
                color: Colors.transparent,
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (_mapController != null) {
                            _mapController.showMarkerInfoWindow(
                                MarkerId(hotelList[index].name));
                            _mapController
                                .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                bearing: 0,
                                target: LatLng(
                                    hotelList[index].location.latitude,
                                    hotelList[index].location.longitude),
                                zoom: 14.0,
                              ),
                            ));
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            height: 150,
                            padding: EdgeInsets.all(30),
                            margin: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                ClipRRect(
                                    child: Image.asset(
                                  'assets/images/hotel.jpg',
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                )),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${hotelList[index].name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${hotelList[index].des}"),
                                    Text("NA"),
                                  ],
                                )
                              ],
                            )),
                      );
                    })),
            bottom: 10,
          )
        ],
      ),
    );
  }

  Set<Marker> createMarker(List<HotelInfo> hotelList) {
    Set<Marker> markerSet = {};
    hotelList.forEach((element) {
      markerSet.add(Marker(
          markerId: MarkerId(element.name),
          position: element.location,
          infoWindow: InfoWindow(
            title: element.name,
          )));
    });

    return markerSet;
  }
}
