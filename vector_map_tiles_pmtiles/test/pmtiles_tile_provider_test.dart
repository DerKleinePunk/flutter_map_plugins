import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pmtiles/pmtiles.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_map_tiles_pmtiles/vector_map_tiles_pmtiles.dart';

import 'integration_test.mocks.dart';

Future<void> main() async {
  test('Create tile provider from archive', () {
    final mockPmTiles = MockPmTilesArchive();
    final provider = PmTilesVectorTileProvider.fromArchive(mockPmTiles);
    expect(provider.archive, equals(mockPmTiles));
    expect(provider.type, TileProviderType.vector);
  });

  test('Provide tile bytes from archive', () async {
    final mockPmTiles = MockPmTilesArchive();
    when(mockPmTiles.tile(any)).thenAnswer(
      (_) async => Tile(
        0,
        bytes: Uint8List.fromList([1, 2, 3]),
        compression: Compression.none,
        type: TileType.mvt,
      ),
    );

    final provider = PmTilesVectorTileProvider.fromArchive(mockPmTiles);
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
