/*
 * @widget PokemonHeader
 * @description Widget que contiene la imagen del pokemon con el diseño semicircular
 * @autor Angela Andrade
 * @version 1.0 25/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import 'trimmed_network_image.dart';

class PokemonHeader extends StatelessWidget {
  final double height; // Altura del header
  final String? primaryType; // Tipo primario del Pokémon
  final String? imageUrl; // URL de la imagen

  final double imageWidthFactor; // porcentaje del ancho disponible
  final double imageHeightFactor; // porcentaje de la altura del header
  final double overlapFactor; // porcentaje de la altura de la imagen que cruza el borde

  const PokemonHeader({
    super.key,
    required this.height,
    this.primaryType,
    this.imageUrl,
    this.imageWidthFactor = 0.4,
    this.imageHeightFactor = 0.6,
    this.overlapFactor = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final imageWidth = w * imageWidthFactor;
          final imageHeight = height * imageHeightFactor;
          final overlap = imageHeight * overlapFactor;
          final bgColor = primaryType != null
              ? PokemonTypeColors.getTypeColor(primaryType!)
              : AppColors.blue1E88E5;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Fondo semicírculo
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(180),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(180),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                ),
              ),
              // Logo del tipo del pokemon
              if (primaryType != null)
                Positioned.fill(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Color(0x66FFFFFF),
                        Color(0x1AFFFFFF),
                      ],
                      stops: [0.3, 0.7, 1.0],
                    ).createShader(bounds),
                    blendMode: BlendMode.dstIn,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 50),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 1,
                            child: SvgPicture.asset(
                              PokemonTypeColors.getTypeLogoPath(primaryType!),
                              fit: BoxFit.contain,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                    ),
                  ),
                ),
              // Imagen del Pokémon cruzando el borde
              if (imageUrl != null && imageUrl!.isNotEmpty)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -overlap,
                  child: Center(
                    child: SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: TrimmedNetworkImage(
                        url: imageUrl!,
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}


