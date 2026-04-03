import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pmtiles/pmtiles.dart';

@GenerateNiceMocks([MockSpec<PmTilesArchive>()])
import 'integration_test.mocks.dart';
import 'utils/test_app.dart';

Future<void> main() async {
  testWidgets('FlutterMap with PmTilesVectorTileProvider', (tester) async {
    final pmTiles = MockPmTilesArchive();
    when(pmTiles.tile(captureAny)).thenAnswer(
      (params) async => Tile(
        params.positionalArguments.first as int,
        bytes: TileProvider.transparentImage,
        compression: Compression.none,
        type: TileType.png,
      ),
    );

    await tester.pumpWidget(TestApp(pmTiles: pmTiles));
    await tester.pump();

    // Dispose vector tile layer timers before test end.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 4));
  });
}
