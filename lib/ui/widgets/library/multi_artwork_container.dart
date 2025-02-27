import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:namida/core/extensions.dart';
import 'package:namida/ui/widgets/artwork.dart';
import 'package:namida/ui/widgets/custom_widgets.dart';

class MultiArtworkContainer extends StatelessWidget {
  final double size;
  final Widget? child;
  final Widget? onTopWidget;
  final List<String>? paths;
  final EdgeInsetsGeometry? margin;
  final String heroTag;
  const MultiArtworkContainer({super.key, required this.size, this.child, this.margin, this.paths, this.onTopWidget, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.all(3.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.theme.cardTheme.color?.withAlpha(180),
        borderRadius: BorderRadius.circular(18.0.multipliedRadius),
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor.withAlpha(180),
            blurRadius: 8,
            offset: const Offset(0, 2.0),
          )
        ],
      ),
      child: NamidaHero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0.multipliedRadius),
          child: Stack(
            children: [
              if (paths != null)
                MultiArtworks(
                  disableHero: true,
                  heroTag: heroTag,
                  paths: paths!,
                  thumbnailSize: size - 6.0,
                ),
              if (child != null) child!,
              if (onTopWidget != null) onTopWidget!,
            ],
          ),
        ),
      ),
    );
  }
}
