import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/news/bloc/news_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/image_picker.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescController = TextEditingController();
  // final addNewsBloc = NewsBloc();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Add News"))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Remember to post only truthful news. Your news will be verified by admin. Any suspicious activity can risk you being on blacklist.",
                      style:
                          TextStyle(color: Color.fromARGB(255, 120, 120, 120)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CustomTextFormField(
                hintText: "News Title",
                controller: newsTitleController,
                context: context,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Description",
                controller: newsDescController,
                context: context,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 13.0),
                child: Text("Add Image",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // color: Color.fromARGB(255, 126, 126, 126),
                        fontWeight: FontWeight.normal,
                        fontFamily: "poppins",
                        fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ImagePickerWidget(
                onImageSelected: (File? selectedImage) {
                  setState(() {
                    this.selectedImage = selectedImage;
                  });
                },
                descriptionText: "Add a verifying image",
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                  text: "Submit",
                  backgroundColorBtn: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    // addNewsBloc.add(PostNews(
                    //     description: newsDescController.text.trim(),
                    //     image: selectedImage,
                    //     title: newsTitleController.text.trim()));
                    context.read<NewsBloc>().add(PostNews(
                        description: newsDescController.text.trim(),
                        image: selectedImage,
                        title: newsTitleController.text.trim()));

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('News posted successfully'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    });

                    Navigator.push(
                        context,
                        GeneratedRoute().onGeneratedRoute(
                          RouteSettings(name: '/home'),
                        ));
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
