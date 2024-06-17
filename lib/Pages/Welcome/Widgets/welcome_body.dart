import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Config/strings.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsImage.boyPic),
            SvgPicture.asset(AssetsImage.connectSVG),
            Image.asset(AssetsImage.girlPic)
          ],
        ),
        const SizedBox(height: 40),
        Text(
          WelcomePageString.nowYouAre,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text(
          WelcomePageString.connected,
          style: TextStyle(
            fontSize: 32,
            color: Color(0xFFFF9900),
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          WelcomePageString.discription,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
