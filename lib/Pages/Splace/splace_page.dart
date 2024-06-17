import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/splace_controller.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    return Scaffold(
        body: Center(
      child: SvgPicture.asset(AssetsImage.appIconSVG),
    ));
  }
}
