import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pmtiles/pmtiles.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_map_tiles_pmtiles/vector_map_tiles_pmtiles.dart';

class MockPmTilesArchive extends Mock implements PmTilesArchive {}

Future<void> main() async {
  test('Create tile provider from archive', () {
    final mockPmTiles = MockPmTilesArchive();
    final provider = PmTilesVectorTileProvider.fromArchive(mockPmTiles);
    expect(provider.archive, equals(mockPmTiles));
    expect(provider.type, TileProviderType.vector);
  });
  test('Create tile provider from source', () async {
    const source =
        'https://raw.githubusercontent.com/protomaps/PMTiles/main/spec/v3/protomaps(vector)ODbL_firenze.pmtiles';
    final provider = await PmTilesVectorTileProvider.fromSource(source);
    expect(provider.type, TileProviderType.vector);
    expect(
      provider.archive.centerPosition.latitude,
      closeTo(43.7672134, 0.1),
    );
    expect(
      provider.archive.centerPosition.longitude,
      closeTo(11.2543435, 0.1),
    );
    expect(provider.maximumZoom, equals(15));
    expect(provider.minimumZoom, equals(0));
    expect(
      await provider.provide(TileIdentity(0, 0, 0)),
      equals(Uint8List.fromList([1, 2, 3])),
    );
  });

  test('Throws provider exception for missing tile', () async {
    final mockPmTiles = MockPmTilesArchive();
    when(mockPmTiles.tile(any)).thenThrow(TileNotFoundException(0));

    final provider = PmTilesVectorTileProvider.fromArchive(mockPmTiles);
    await expectLater(
      provider.provide(TileIdentity(1, 1, 1)),
      throwsA(isA<ProviderException>()),
    );
  });

  test('Accepts a type', () {
    final mockPmTiles = MockPmTilesArchive();
    final provider = PmTilesVectorTileProvider.fromArchive(
      mockPmTiles,
      type: TileProviderType.raster,
    );
    expect(provider.type, TileProviderType.raster);
  });
}
