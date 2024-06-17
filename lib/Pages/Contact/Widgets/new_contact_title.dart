import 'package:flutter/material.dart';

class NewContactTitle extends StatelessWidget {
  const NewContactTitle({
    super.key,
    required this.btnName,
    required this.icon,
    required this.onTap
  });

  final String btnName;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primaryContainer
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              child:  Icon(icon, size: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            SizedBox(width: 20),
            Text(btnName, style: Theme.of(context).textTheme.bodyLarge,)
          ],
        ),
      ),
    );
  }
}
