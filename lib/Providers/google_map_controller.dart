import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapCtrl extends ChangeNotifier {
  String address = "Add location";
  LatLng? lt;
  static LatLng _kMapCenter = const LatLng(6.9271, 79.8612);

  static CameraPosition kInitialPostion =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  Set<Marker> createMarker(LatLng position) {
    return {
      Marker(
        markerId: const MarkerId("marker_2"),
        position: position,
      ),
    };
  }

  Future<void> getAddressFromLatLong(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  setTarget(LatLng target) {
    lt = target;

    notifyListeners();
  }

  static setKMap(LatLng latlang) {
    _kMapCenter = latlang;
  }

  setAddressDefault() {
    address = "Add location";
    notifyListeners();
  }
}
