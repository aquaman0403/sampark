import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(40),
    child: TabBar(
      controller: tabController,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      tabs: const [
        Text(
          "Tin nhắn"
        ),
        Text(
          "Nhóm"
        ),
        Text(
          "Cuộc gọi"
        ),
      ],
    ),
  ); // TabBar ); // PreferredSize
}
