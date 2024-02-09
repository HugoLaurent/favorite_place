import 'package:flutter/material.dart';

import 'package:favorite_place/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(latidude: 37.422, longitude: -122.084, address: ""),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            _pickedPosition = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latidude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickedPosition == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: _pickedPosition ??
                      LatLng(
                        widget.location.latidude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
