/*
 * @widget CustomSkeletonShimmer
 * @description Aplica un efecto shimmer (barrido) sobre su child para simular carga.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

class CustomSkeletonShimmer extends StatefulWidget {
  // Child sobre el que se aplicará el efecto shimmer
  final Widget child;
  // Color base del skeleton
  final Color baseColor;
  // Color del highlight (barrido)
  final Color highlightColor;
  // Duración del ciclo de animación
  final Duration duration;

  const CustomSkeletonShimmer({
    super.key,
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<CustomSkeletonShimmer> createState() => _CustomSkeletonShimmerState();
}

class _CustomSkeletonShimmerState extends State<CustomSkeletonShimmer>
    with SingleTickerProviderStateMixin {
  // Controlador de la animación
  late final AnimationController _controller;

  /*
  * @method initState
  * @description Inicializa el controlador de animación.
  */
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  /*
  * @method dispose
  * @description Libera los recursos del Controller cuando el widget se elimina.
  */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        // Valor de -1 a 1 para desplazar el gradiente horizontalmente
        final slidePercent = (_controller.value * 2) - 1;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                widget.baseColor,
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
              // Desplazamos el gradiente a lo largo del ancho del child
              transform: _SlidingGradientTransform(slidePercent),
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent; // -1.0 a 1.0
  // Constructor
  const _SlidingGradientTransform(this.slidePercent);

  // Transformación de la matriz para desplazar el gradiente
  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
