import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Config/strings.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeFooterButton extends StatelessWidget {
  const WelcomeFooterButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Get.offAllNamed("/authPage");
        return null;
      },
      sliderButtonIcon: Container(
        width: 28,
        height: 28,
        child: SvgPicture.asset(AssetsImage.plugSVG),
      ),
      text: WelcomePageString.slideToStart,
      textStyle: Theme.of(context).textTheme.labelLarge,
      animationDuration: const Duration(milliseconds: 500),
      submittedIcon: SvgPicture.asset(AssetsImage.connectSVG),
      innerColor: const Color(0xFFFF9900),
      outerColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
