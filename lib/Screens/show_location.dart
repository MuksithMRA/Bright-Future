import 'package:brightfuture/Providers/google_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ShowLocation extends StatefulWidget {
  final double lat;
  final double lng;
  const ShowLocation({Key? key, required this.lat, required this.lng})
      : super(key: key);

  @override
  State<ShowLocation> createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {
  static CameraPosition? _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lng),
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kGooglePlex ?? GoogleMapCtrl.kInitialPostion,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Provider.of<GoogleMapCtrl>(context, listen: false)
              .createMarker(_kGooglePlex!.target),
        ),
      ),
    );
  }
}
