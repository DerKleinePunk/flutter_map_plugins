import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<MbTiles>()])
import 'integration_test.mocks.dart';
import 'utils/test_app.dart';

Future<void> main() async {
  testWidgets('FlutterMap with MbTilesVectorTileProvider', (tester) async {
    final mbtiles = MockMbTiles();
    when(mbtiles.getMetadata()).thenAnswer(
      (_) => const MbTilesMetadata(name: 'MockMbTiles', format: 'pbf'),
    );
    when(mbtiles.getTile(x: anyNamed('x'), y: anyNamed('y'), z: anyNamed('z')))
        .thenAnswer((_) => null);

    await tester.pumpWidget(TestApp(mbTiles: mbtiles));
    await tester.pump();

    // Dispose vector tile layer timers before test end.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 4));
  });
}
