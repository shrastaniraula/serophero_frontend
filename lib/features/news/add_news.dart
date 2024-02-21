import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/image_picker.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  TextEditingController newsTitleController = new TextEditingController();
  TextEditingController newsDescController = new TextEditingController();

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
                color: Colors.black,
              ),
            ),
            const Text(
              "Add News",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Remember to post only truthful news. Your news will be verified by admin. Any suspicious activity can risk you being on blacklist.",
                      style:
                          TextStyle(color: Color.fromARGB(255, 120, 120, 120)),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 200,
                      width: 300,
                      alignment: Alignment.center,
                      child: Image.asset(
                          'assets/images/onboarding/onboarding1.png'),
                    ),
                  ],
                ),
              ),
              CustomTextFormField(
                hintText: "News Title",
                controller: newsTitleController, context: context,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Description",
                controller: newsDescController, context: context,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 13.0),
                child: Text("Add Image",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromARGB(255, 126, 126, 126),
                        fontWeight: FontWeight.normal,
                        fontFamily: "poppins",
                        fontSize: 18)),
              ),
              const SizedBox(height: 10),
              ImagePickerWidget(
                onImageSelected: (File? selectedImage) {
                  setState(() {
                  });
                },
                descriptionText: "Add a verifying image",
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(text: "Submit", onPressed: () {}),
            ],
          ),
        ),
      )),
    );
  }
}
