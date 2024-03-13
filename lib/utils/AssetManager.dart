import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetManager {
  static const Map<String, Map<String, List<String>>> propertyAssets = {
    'Hair': {
      'HairStyle': [
        'assets/hairStyle/bun.svg',
        'assets/hairStyle/short.svg',
      ],
    },
    'Eyebrow': {
      'Eyebrowstyle': [
        'assets/Eyebrow/arched.svg',
        'assets/Eyebrow/beans.svg',
      ]
    },
    'Nose': {
      'NoseShape': [
        'assets/nose/crooked.svg',
        'assets/nose/long.svg',
        'assets/nose/normal.svg'
      ]
    },
    'Beard': {
      'Beardstyle': ['assets/Beard/beard.svg', 'assets/Beard/fullbeard.svg']
    },
    'Eyes': {
      'EyeColor': ['assets/Eyes/arched.svg']
    },
    'Hats': {
      'HatsDesign': ['assets/Hats/hijab.svg', 'assets/Hats/kippa.svg']
    },
  };
}
