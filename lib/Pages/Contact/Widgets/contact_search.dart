import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  const ContactSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => {
                print(value)
              },
              decoration: const InputDecoration(
                  hintText: "Search Contact",
                  prefixIcon: Icon(Icons.search)
              ),
            ),
          )
        ],
      ),
    );
  }
}
