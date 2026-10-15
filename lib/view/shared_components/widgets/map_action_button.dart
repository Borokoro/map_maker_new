import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';

class MapActionButton extends StatelessWidget {
  const MapActionButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  static const double _iconSize = 20;
  static const double _elevation = 3;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      elevation: _elevation,
      highlightElevation: _elevation,
      backgroundColor: ColorConstants.bgSurface,
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: StyleConstants.radius100,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      mini: true,
      child: Icon(
        icon,
        color: ColorConstants.textPrimary,
        size: _iconSize,
      ),
    );
  }
}
