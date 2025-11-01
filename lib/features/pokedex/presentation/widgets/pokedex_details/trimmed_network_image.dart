/*
 * @widget TrimmedNetworkImage
 * @description Widget que controla la carga y renderizado de una imagen desde una URL
 * @autor Angela Andrade
 * @version 1.0 25/10/2025 Documentación y creación de la clase.
 */

import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TrimmedNetworkImage extends StatefulWidget {
  final String url; // URL de la imagen
  final double? width; // Ancho de la imagen
  final double? height; // Altura de la imagen
  final BoxFit fit; // Cómo ajustar la imagen dentro del espacio disponible

  const TrimmedNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  State<TrimmedNetworkImage> createState() => _TrimmedNetworkImageState();
}

class _TrimmedNetworkImageState extends State<TrimmedNetworkImage> {
  // Future para cargar y decodificar la imagen
  late Future<_DecodedAndRect> _future;
  // Último resultado decodificado
  _DecodedAndRect? _lastResolved;

  /*
 @method initState
 @description Inicializa el estado del widget y comienza la carga de la imagen.
 */
  @override
  void initState() {
    super.initState();
    _future = _loadDecodeAndBounds(widget.url);
  }

  /* @method didUpdateWidget
 @description Maneja la actualización del widget y reinicia la carga si la URL cambia.
 @param oldWidget - El widget anterior.
*/

  @override
  void didUpdateWidget(covariant TrimmedNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _future = _loadDecodeAndBounds(widget.url);
      _lastResolved = null; // resetea solo si url cambia
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_DecodedAndRect>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _lastResolved = snapshot.data;
        }

        final decoded = _lastResolved;
        if (decoded == null) {
          return const SizedBox.shrink();
        }
        // Dibuja la imagen recortada
        return _CroppedImagePaint(
          image: decoded.image,
          src: decoded.srcRect,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      },
    );
  }
}

// Helper class para contener la imagen decodificada y el rectángulo de recorte
class _DecodedAndRect {
  final ui.Image image;
  final Rect srcRect;
  const _DecodedAndRect(this.image, this.srcRect);
}

// Carga la imagen desde la URL, la decodifica y calcula el rectángulo de contenido visible
Future<_DecodedAndRect> _loadDecodeAndBounds(String url) async {
  final dio = Dio();
  final resp = await dio.get<List<int>>(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  final bytes = Uint8List.fromList(resp.data!);

  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  final image = frame.image;

  final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData == null)
    return _DecodedAndRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
    );

  final bounds = await compute(_computeBounds, {
    'bytes': byteData.buffer.asUint8List(),
    'width': image.width,
    'height': image.height,
  });

  final rect = Rect.fromLTWH(
    bounds[0].toDouble(),
    bounds[1].toDouble(),
    (bounds[2] - bounds[0] + 1).toDouble(),
    (bounds[3] - bounds[1] + 1).toDouble(),
  );
  return _DecodedAndRect(image, rect);
}

List<int> _computeBounds(Map<String, dynamic> args) {
  final bytes = args['bytes'] as Uint8List;
  final width = args['width'] as int;
  final height = args['height'] as int;

  int top = height, left = width, right = -1, bottom = -1;
  const int threshold = 10; // alfa > 10 => visible

  // rawRgba: 4 bytes por pixel (R,G,B,A)
  int index = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final a = bytes[index + 3];
      if (a > threshold) {
        if (x < left) left = x;
        if (x > right) right = x;
        if (y < top) top = y;
        if (y > bottom) bottom = y;
      }
      index += 4;
    }
  }

  if (right < left || bottom < top) {
    return [0, 0, width - 1, height - 1];
  }
  return [left, top, right, bottom];
}

// Widget para pintar la imagen recortada
class _CroppedImagePaint extends StatelessWidget {
  final ui.Image image;
  final Rect src;
  final double? width;
  final double? height;
  final BoxFit fit;

  const _CroppedImagePaint({
    required this.image,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _CroppedPainter(image: image, src: src, fit: fit),
      ),
    );
  }
}

// Pintor personalizado para renderizar la imagen recortada
class _CroppedPainter extends CustomPainter {
  final ui.Image image;
  final Rect src;
  final BoxFit fit;
  _CroppedPainter({required this.image, required this.src, required this.fit});

  @override
  void paint(Canvas canvas, Size size) {
    final dst = _applyBoxFitToRect(fit, src.size, size);
    final paint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant _CroppedPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.src != src ||
        oldDelegate.fit != fit;
  }

  Rect _applyBoxFitToRect(BoxFit fit, Size inputSize, Size outputSize) {
    final fittedSizes = applyBoxFit(fit, inputSize, outputSize);
    final destinationSize = fittedSizes.destination;
    final halfWidthDelta = (outputSize.width - destinationSize.width) / 2.0;
    final halfHeightDelta = (outputSize.height - destinationSize.height) / 2.0;
    return Rect.fromLTWH(
      halfWidthDelta,
      halfHeightDelta,
      destinationSize.width,
      destinationSize.height,
    );
  }
}
