import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = new TextEditingController();

  List<FormData> formDataList = [
    FormData("Username", "Username", TextEditingController(text: "shrasta")),
    FormData("Firstname", "Firstname", TextEditingController(text: "Shrasta")),
    FormData("Lastname", "Lastname", TextEditingController(text: "Niraula")),
    FormData("Email", "Email",
        TextEditingController(text: "shrastatsarhanna@gmail.com")),
    FormData("Address", "Address", TextEditingController(text: "Biratnagar")),
    FormData("Phone Number", "Phone Number",
        TextEditingController(text: "9803724876")),
    // FormData("Email", "Email", TextEditingController(text: "shrastatsarhanna@gmail.com")),FormData("Username", "Username", TextEditingController(text: "shrasta")),
    FormData("Business", "Business", TextEditingController(text: "Okay")),
    // Add more items as needed
  ];

  void printFormDataValues() {
    for (FormData formData in formDataList) {
      String value = formData.controller.text;
      print("${formData.hintText} value: $value");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('EditProfile')),
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "Click any fields to edit",
                  style: TextStyle(color: Color.fromARGB(255, 120, 120, 120)),
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
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: formDataList.length,
              itemBuilder: (context, index) {
                FormData formData = formDataList[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      formData.title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 126, 126, 126),
                        fontWeight: FontWeight.normal,
                        fontFamily: "poppins",
                        fontSize: 18,
                      ),
                    ),
                    CustomTextFormField(
                      hintText: formData.hintText,
                      controller: formData.controller,
                      context: context,
                    ),
                  ],
                );
              },
            ),
          ),
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
                    offset: const Offset(0, 2), // Adjust the shadow offset
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
    )));
  }
}

class FormData {
  final String title;
  final String hintText;
  final TextEditingController controller;

  FormData(this.title, this.hintText, this.controller);
}
