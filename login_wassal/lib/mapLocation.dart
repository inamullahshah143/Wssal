import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:wassal_customer/const.dart';

// ignore: must_be_immutable
class MapLoacation extends StatefulWidget {
  Position currentPosition;
  MapLoacation({
    @required this.currentPosition,
  });
  @override
  _MapLoacationState createState() =>
      _MapLoacationState(currentPosition: currentPosition);
}

class _MapLoacationState extends State<MapLoacation> {
  Position currentPosition;
  _MapLoacationState({
    @required this.currentPosition,
  });
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    PickResult selectedPlace;
    final LatLng _center =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: MediaQuery.of(context).size.height / 1.295,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: PlacePicker(
        apiKey: 'AIzaSyAMp8UY-G3eUJeinsx6uwK-j0lXFYB_KWo',
        initialPosition: _center,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePlaceDetailSearch: true,
        onPlacePicked: (result) {
          selectedPlace = result;
          Navigator.of(context).pop();
          setState(() {});
        },
        forceSearchOnZoomChanged: true,
        automaticallyImplyAppBarLeading: false,
        selectedPlaceWidgetBuilder:
            (_, selectedPlace, state, isSearchBarFocused) {
          return isSearchBarFocused
              ? Container()
              : Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Container(
                      width: double.infinity,
                      child: state == SearchingState.Searching
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 3.0,
                                    offset: Offset(0.0, 0.5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      selectedPlace.formattedAddress,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        selectedLocation =
                                            selectedPlace.formattedAddress;
                                        cureentLat =
                                            selectedPlace.geometry.location.lat;
                                        cureentLng =
                                            selectedPlace.geometry.location.lng;
                                        locationChange = true;
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0),
                                        ),
                                        primary: themePrimaryColor,
                                      ),
                                      child: Text(
                                        "Pick Here",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                );
        },
        pinBuilder: (context, state) {
          if (state == PinState.Idle) {
            return Icon(Icons.location_on, color: Colors.red);
          } else {
            return Icon(Icons.location_on_outlined, color: Colors.red);
          }
        },
      ),
    );
  }
}
