import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/contact_controller.dart';
import 'package:sampark/Controller/image_picker.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Controller/status_controller.dart';
import 'package:sampark/Pages/CallHistory/call_history.dart';
import 'package:sampark/Pages/Groups/group_page.dart';
import 'package:sampark/Pages/Home/Widgets/chat_list.dart';
import 'package:sampark/Pages/Home/Widgets/tab_bar.dart';
import 'package:sampark/Pages/Profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());
    ImagePickerController imagePickerController = Get.put(ImagePickerController());
    StatusController statusController = Get.put(StatusController());
    return RefreshIndicator(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(
                'Sampark',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AssetsImage.appIconSVG),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    contactController.getChatRoomList();
                  },
                  icon: const Icon(Icons.search_rounded),
                ),
                IconButton(
                  onPressed: () async {
                    Get.to(const ProfilePage());
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
              bottom: myTabBar(tabController, context),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed("/contactPage");
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: TabBarView(
                controller: tabController,
                children: const [
                  ChatList(),
                  GroupPage(),
                  CallHistory(),
                ],
              ),
            )),
        onRefresh: () {
          return contactController.getChatRoomList();
        });
  }
}
