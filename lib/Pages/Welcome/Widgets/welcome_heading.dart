import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Config/images.dart';
import '../../../Config/strings.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsImage.appIconSVG,
               width: 82,
               height: 78,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
