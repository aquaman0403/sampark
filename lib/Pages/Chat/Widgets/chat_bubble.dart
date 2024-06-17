import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark/Config/images.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isComming,
    required this.time,
    required this.status,
    required this.imageUrl,
    required this.senderImageUrl,
    required this.senderName,
  });

  final String message;
  final bool isComming;
  final String time;
  final String status;
  final String imageUrl;
  final String senderImageUrl;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          if (isComming)
            Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 50),
              child: Text(
                senderName,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (isComming)
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(senderImageUrl),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        minWidth: 0,
                        maxWidth: MediaQuery.sizeOf(context).width / 1.3,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: isComming
                            ? const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10),
                        )
                            : const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: imageUrl == ""
                          ? Text(message)
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                          message == "" ? Container() : const SizedBox(height: 10),
                          message == "" ? Container() : Text(message),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if (isComming)
                          Text(time, style: Theme.of(context).textTheme.labelMedium)
                        else
                          Row(
                            children: [
                              Text(time, style: Theme.of(context).textTheme.labelMedium),
                              const SizedBox(width: 10),
                              SvgPicture.asset(AssetsImage.chatStatusSvg, width: 20),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
