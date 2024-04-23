import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:serophero/features/business/bloc/directories_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/image_picker.dart';
import 'package:serophero/widgets/snackbar.dart';

class BusinessRegister extends StatefulWidget {
  const BusinessRegister({super.key});

  @override
  State<BusinessRegister> createState() => _BusinessRegisterState();
}

class _BusinessRegisterState extends State<BusinessRegister> {
  File? _citizen1;
  File? _citizen2;
  File? _document1;
  File? _document2;
  File? _document3;
  TextEditingController businessController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Register Business"))),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Business Name",
                    controller: businessController,
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Description",
                    controller: descController,
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  const Text("Add Image",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  ImagePickerWidget(
                    onImageSelected: (File? selectedImage) {
                      setState(() {
                        _citizen1 = selectedImage;
                      });
                    },
                    descriptionText: "Citizenship front",
                  ),
                  const SizedBox(height: 20),
                  ImagePickerWidget(
                    onImageSelected: (File? selectedImage) {
                      setState(() {
                        _citizen2 = selectedImage;
                      });
                    },
                    descriptionText: "Citizenship back",
                  ),
                  const SizedBox(height: 20),
                  const Text("Add Image",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  ImagePickerWidget(
                    onImageSelected: (File? selectedImage) {
                      setState(() {
                        _document1 = selectedImage;
                      });
                    },
                    descriptionText: "Verifying document 1",
                  ),
                  const SizedBox(height: 20),
                  ImagePickerWidget(
                    onImageSelected: (File? selectedImage) {
                      setState(() {
                        _document2 = selectedImage;
                      });
                    },
                    descriptionText: "Verifying document 2",
                  ),
                  const SizedBox(height: 20),
                  ImagePickerWidget(
                    onImageSelected: (File? selectedImage) {
                      setState(() {
                        _document3 = selectedImage;
                      });
                    },
                    descriptionText: "Verifying document 2",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            CustomElevatedButton(
                text: "Register",
                backgroundColorBtn: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  context
                      .read<BusinessBloc>()
                      .add(DirectoryRegisterButtonClicked(
                        name: businessController.text,
                        description: descController.text,
                        citizenFront: File(_citizen1!.path),
                        citizenBack: File(_citizen2!.path),
                        doc1: File(_document1!.path),
                        doc2: File(_document2!.path),
                        doc3: File(_document3!.path),
                      ));

                  MySnackbar.show(
                    context,
                    title: "Business Registered Successfully",
                    message:
                        "Your business can be seen by users when an admin verifies it.",
                    type: SnackbarType.success,
                  );

                  Navigator.push(
                      context,
                      GeneratedRoute().onGeneratedRoute(
                        RouteSettings(name: '/home'),
                      ));
                }),
            const SizedBox(height: 10),
          ]),
        )));
  }
}
