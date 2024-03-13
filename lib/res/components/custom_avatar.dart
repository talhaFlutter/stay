import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stay_x/res/colors/app_color.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar(
      {super.key, required this.onPress, required this.assetPaths});
  final VoidCallback onPress;
  final List<String> assetPaths;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.appText,
                width: 2.0,
              ),
            ),
            child: Stack(
              children: List.generate(
                assetPaths.length,
                (index) => Positioned(
                  top: index * 20.0, // Adjust the position of each SVG
                  child: SvgPicture.asset(
                    assetPaths[index],
                    width: 100, // Adjust the width as per your requirement
                    height: 100, // Adjust the height as per your requirement
                    // Add more properties like alignment, color, etc. as needed
                  ),
                ),
              ),
            )));
  }
}
