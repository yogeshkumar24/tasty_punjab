import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelInfo {
  String name;
  String des;
  String image;
  LatLng location;

  HotelInfo(this.name, this.des, this.image, this.location);
}
