import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController =
      TextEditingController(text: "Shrasta");
  TextEditingController lastNameController =
      TextEditingController(text: "Niraula");
  TextEditingController userNameController =
      TextEditingController(text: "shrastaniraula");
  TextEditingController addressController =
      TextEditingController(text: "Biratnagar");
  TextEditingController emailAddressController =
      TextEditingController(text: "userniraula@gmail.com");
  TextEditingController phoneNumberController =
      TextEditingController(text: "9801234876");

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
                'Edit Profile',
              ),
              const SizedBox()
            ],
          ),
        ),
        // appBar: AppBar(title: Text('EditProfile')),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Click any fields to edit ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 120, 120, 120)),
                        ),
                        Icon(Icons.edit,
                            size: 18, color: Color.fromARGB(255, 120, 120, 120))
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {}, //make select image here
                      child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 5,
                          backgroundImage: const AssetImage(
                              'assets/images/defaults/no_image_user.png')),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildTextField(
                    context, "First Name", "FirstName", firstNameController),
                SizedBox(height: 10),
                buildTextField(
                    context, "Last Name", "Lastname", lastNameController),
                SizedBox(height: 10),
                buildTextField(
                    context, "Username", "Username", userNameController),
                SizedBox(height: 10),
                buildTextField(
                    context, "Address", "Address", addressController),
                SizedBox(height: 10),
                buildTextField(context, "Email Address", "Email Address",
                    emailAddressController),
                SizedBox(height: 10),
                buildTextField(context, "Phone Number", "Phone Number",
                    phoneNumberController),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        GeneratedRoute().onGeneratedRoute(
                          const RouteSettings(
                              arguments: '', name: '/business_registration'),
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(10),

                      color: const Color.fromARGB(255, 242, 242,
                          242), // Replace with your desired background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.1), // Adjust shadow color and opacity as needed
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset:
                              const Offset(0, 2), // Adjust the shadow offset
                        ),
                      ],
                    ),
                    child: const Center(
                        child: Text(
                      "Register a business?",
                      style: TextStyle(
                          color: Color.fromRGBO(40, 25, 82, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        )));
  }

  Column buildTextField(BuildContext context, String text, String textHint,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        CustomTextFormField(
          hintText: textHint,
          controller: controller,
          context: context,
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }
}
