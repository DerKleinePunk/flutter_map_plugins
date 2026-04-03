import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pmtiles/pmtiles.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_map_tiles_pmtiles/vector_map_tiles_pmtiles.dart';

class TestApp extends StatelessWidget {
  const TestApp({required this.pmTiles, super.key});

  final PmTilesArchive pmTiles;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FlutterMap(
          options: const MapOptions(
            initialZoom: 0,
            initialCenter: LatLng(0, 0),
          ),
          children: [
            VectorTileLayer(
              tileProviders: TileProviders({
                'protomaps': PmTilesVectorTileProvider.fromArchive(pmTiles),
              }),
              theme: ProtomapsThemes.lightV4(),
            ),
          ],
        ),
      ),
    );
  }
}
