import 'package:flutter/material.dart';
import 'package:sampark/Widgets/primary_button.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: const Icon(
                              Icons.image,
                              size: 40,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text("Personal Infor",
                                style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text("Name",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "Your name",
                              prefixIcon: Icon(
                                Icons.person,
                              )),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text("Email",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "example@email.com",
                              prefixIcon: Icon(
                                Icons.alternate_email_rounded,
                              )),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text("Phone number",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "0123456789",
                              prefixIcon: Icon(
                                Icons.alternate_email_rounded,
                              )),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                              btnName: "Save",
                              icon: Icons.save,
                              onTap: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
