import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../Providers/google_map_controller.dart';
import '../Widgets/CustomText/custom_text.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({Key? key}) : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<GoogleMapCtrl>(
      builder: (context, ctrl, child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                ctrl.getAddressFromLatLong(
                    ctrl.lt ?? GoogleMapCtrl.kInitialPostion.target);
                Navigator.pop(context);
              },
              label: const CustomText(title: "Add Location")),
          body: GoogleMap(
            initialCameraPosition: GoogleMapCtrl.kInitialPostion,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: ctrl
                .createMarker(ctrl.lt ?? GoogleMapCtrl.kInitialPostion.target),
            onCameraMove: ((_position) {
              ctrl.setTarget(_position.target);
            }),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
        );
      },
    ));
  }
}
