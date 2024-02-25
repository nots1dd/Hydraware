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
      initMapWithUserPosition: const UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );
  }

  void prompt(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontFamily: 'Cera Pro')),
              ),
            ),
          ),
        );
      },
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
                showZoomController: false,
                enableRotationByGesture: false,
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(Icons.person_pin_circle,
                        color: Colors.blue, size: 100),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(Icons.person_pin_circle,
                        color: Colors.blue, size: 100),
                  ),
                ),
                zoomOption: const ZoomOption(
                  initZoom: 10,
                ),
              )),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              await controller.setZoom(zoomLevel: 10);
              await controller.currentLocation();
            },
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Icon(
              Icons.my_location,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () async {
              await controller.zoomIn();
            },
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () async {
              await controller.zoomOut();
            },
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
