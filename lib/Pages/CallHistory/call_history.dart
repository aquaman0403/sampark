import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/chat_controller.dart';
import 'package:sampark/Pages/Home/Widgets/chat_title.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DateTime timestamp =
                    DateTime.parse(snapshot.data! [index].timestamp!);
                  String formattedTime = DateFormat('hh:mm a').format(timestamp);
                  return ChatTitle(
                      imageUrl: snapshot.data![index].callerPic ?? AssetsImage.defaultProfileUrl,
                      name: snapshot.data![index].callerName ?? "...",
                      lastChat: snapshot.data![index].time ?? "Not Time",
                      lastTime: formattedTime,
                    );
                });
          } else {
            return Center(
              child: Container(
                width: 200,
                height: 200,
                child: const CircularProgressIndicator()
              ),
            );
          }
        });
  }
}
