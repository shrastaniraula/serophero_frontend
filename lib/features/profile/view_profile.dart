import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
            const Text(
              'View Profile',
            ),
            const SizedBox()
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(
                          'assets/images/defaults/no_image_user.png'),
                    ),
                    const SizedBox(height: 05),
                    Text(
                      "Full Name",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    // const SizedBox(height: 10),
                    const Text(
                      "useremail@gmail.com",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Center(
                      child: Text(
                        "Business User",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 7.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Center(
                      child: Image(
                          height: 22,
                          width: 22,
                          color: Theme.of(context).colorScheme.tertiary,
                          image:
                              const AssetImage("assets/logos/chat_filled.png")),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 7.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: const Center(
                      child: Icon(Icons.report_problem_rounded),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.location_on),
                title: Text("Lives in"),
                subtitle: Text("address"),
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text("Contact number"),
                subtitle: Text("phoneNo"),
              ),
              const ListTile(
                leading: Icon(Icons.email),
                title: Text("Email address"),
                subtitle: Text("email"),
              ),
              const ListTile(
                leading: Icon(Icons.work),
                title: Text("Works at"),
                subtitle: Text("name"),
              ),
              // const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
