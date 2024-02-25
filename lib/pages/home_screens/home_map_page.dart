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
                    icon:
                        Icon(Icons.person_pin_circle, color: Colors.blue, size: 100),
                  ),
                ),
                zoomOption: const ZoomOption(
                  initZoom: 10,
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
          try {
            await controller.setZoom(zoomLevel: 10);
            await controller.currentLocation();
            Navigator.pop(context);
          } catch (e) {
            prompt(e.toString());
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.my_location, color: Colors.white),
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
