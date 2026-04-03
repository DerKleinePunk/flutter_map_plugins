import 'package:flutter_test/flutter_test.dart';
import 'package:vector_map_tiles_pmtiles/vector_map_tiles_pmtiles.dart';

Future<void> main() async {
  test('Build black theme', () {
    final theme = ProtomapsThemes.blackV4();
    expect(theme.tileSources, equals(<String>{'protomaps'}));
  });

  test('Build dark theme', () {
    final theme = ProtomapsThemes.darkV4();
    expect(theme.tileSources, equals(<String>{'protomaps'}));
  });

  test('Build grayscale theme', () {
    final theme = ProtomapsThemes.grayscaleV4();
    expect(theme.tileSources, equals(<String>{'protomaps'}));
  });

  test('Build light theme', () {
    final theme = ProtomapsThemes.lightV4();
    expect(theme.tileSources, equals(<String>{'protomaps'}));
  });

  test('Build white theme', () {
    final theme = ProtomapsThemes.whiteV4();
    expect(theme.tileSources, equals(<String>{'protomaps'}));
  });
}
