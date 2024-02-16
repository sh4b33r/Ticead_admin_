import 'package:google_maps_flutter/google_maps_flutter.dart';

class TheatreModel {
  final String theatreAdminId;
  final String name;
  final String description;
  final List image;
  bool normal = false;
  bool executive = false;
  bool reclined = false;
  bool premium = false;
  String? normalprice;
  String? executiveprice;
  String? premiumprice;
  String? reclinedprice;
  LatLng location;

  TheatreModel(
      {required this.theatreAdminId,
      required this.name,
      required this.description,
      required this.image,
      required this.normal,
      required this.executive,
      required this.premium,
      required this.reclined,
      this.executiveprice = '0',
      this.normalprice = '0',
      this.premiumprice = '0',
      this.reclinedprice = '0',
      required this.location});
}
