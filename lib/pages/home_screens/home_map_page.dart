import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapApp extends StatefulWidget {
  const MapApp({super.key});
  @override
  State<StatefulWidget> createState() => MapAppState();
}

class MapAppState extends State<MapApp> with AutomaticKeepAliveClientMixin {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          OSMFlutter(
              controller: controller,
              osmOption: OSMOption(
                showZoomController: true,
                enableRotationByGesture: false,
                userLocationMarker: UserLocationMaker(
                  personMarker: MarkerIcon(
                    icon: Icon(Icons.person_pin_circle,
                        color: Colors.blue, size: 100),
                  ),
                  directionArrowMarker: MarkerIcon(
                    icon:
                        Icon(Icons.arrow_upward, color: Colors.blue, size: 100),
                  ),
                ),
                zoomOption: ZoomOption(
                  initZoom: 10,
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.background,
        onPressed: () async {
          await controller.setZoom(zoomLevel: 10);
          await controller.currentLocation();
        },
        child: Icon(Icons.my_location,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
