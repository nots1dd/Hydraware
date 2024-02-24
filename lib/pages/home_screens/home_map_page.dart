import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hydraware/components/tile_providers.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
class MapApp extends StatefulWidget {
  const MapApp({super.key});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  late AlignOnUpdate _alignPositionOnUpdate;
  late final StreamController<double?> _alignPositionStreamController;

  @override
  void initState() {
    super.initState();
    _alignPositionOnUpdate = AlignOnUpdate.always;
    _alignPositionStreamController = StreamController<double?>();
  } 

  @override
  void dispose() {
    _alignPositionStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialZoom: 10,
        // Stop aligning the location marker to the center of the map widget
        // if user interacted with the map.
        onPositionChanged: (MapPosition position, bool hasGesture) {
          if (hasGesture && _alignPositionOnUpdate != AlignOnUpdate.never) {
            setState(
              () => _alignPositionOnUpdate = AlignOnUpdate.never,
            );
          }
        },
      ),
      // ignore: sort_child_properties_last
      children: [
        openStreetMapTileLayer,
        CurrentLocationLayer(
          alignPositionStream: _alignPositionStreamController.stream,
          alignPositionOnUpdate: _alignPositionOnUpdate,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                setState(
                  () => _alignPositionOnUpdate = AlignOnUpdate.always,
                );
                _alignPositionStreamController.add(10);
              },
              child: Icon(
                Icons.my_location,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}