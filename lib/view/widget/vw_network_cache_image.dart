import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show Codec;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VWNetworkCacheImage extends ImageProvider<VWNetworkCacheImage> {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments must not be null.
  const VWNetworkCacheImage(this.url, {this.scale = 1.0, this.headers})
      : assert(url != null),
        assert(scale != null);

  /// The URL from which the image will be fetched.
  final String url;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  final Map<String, String> headers;

  @override
  Future<VWNetworkCacheImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<VWNetworkCacheImage>(this);
  }

  @override
  ImageStreamCompleter load(VWNetworkCacheImage key) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>('Image provider', this);
        yield DiagnosticsProperty<VWNetworkCacheImage>('Image key', key);
      }
    );
  }

  static final HttpClient _httpClient = HttpClient();

  Future<ui.Codec> _loadAsync(VWNetworkCacheImage key) async {
    assert(key == this);

    final fileInfo = await DefaultCacheManager().getFileFromCache(key.url);
    if (fileInfo != null && fileInfo.file != null) {
      final Uint8List cacheBytes = await fileInfo.file.readAsBytes();
      if (cacheBytes != null) {
        return PaintingBinding.instance.instantiateImageCodec(cacheBytes);
      }
    }


    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    headers?.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok)
      throw Exception('HTTP request failed, statusCode: ${response?.statusCode}, $resolved');

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0) throw Exception('NetworkCacheImage is an empty file: $resolved');

    /// add this start
    await DefaultCacheManager().putFile(key.url, bytes);

    /// add this edn

    return PaintingBinding.instance.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final VWNetworkCacheImage typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
