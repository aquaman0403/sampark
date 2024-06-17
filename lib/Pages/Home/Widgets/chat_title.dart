import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatTitle extends StatelessWidget {
 
  const ChatTitle({
    super.key, 
    required this.imageUrl, 
    required this.name, 
    required this.lastChat, 
    required this.lastTime
  });
  final String imageUrl;
  final String name;
  final String lastChat;
  final String lastTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: 70,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        lastChat,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            lastTime,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
