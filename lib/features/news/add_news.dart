import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/news/bloc/news/news_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/image_picker.dart';
import 'package:serophero/widgets/snackbar.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Add News"))),
      body: BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state is NewsPostSuccess) {
            MySnackbar.show(
              context,
              title: "News Posted Successfully",
              message: "Your news can be seen after admin verifies.",
              type: SnackbarType.success,
            );
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(
                  const RouteSettings(name: '/home'),
                ));
          }
          if (state is NewsListFailure) {
            MySnackbar.show(
              context,
              title: "Something went wrong",
              message: "Your news cannot be added, Try again later",
              type: SnackbarType.error,
            );
          }
        },
        child: SafeArea(
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
                        style: TextStyle(
                            color: Color.fromARGB(255, 120, 120, 120)),
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
                Center(
                  child: BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                          isLoading: state is NewsListLoading,
                          text: "Submit",
                          backgroundColorBtn:
                              Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            context.read<NewsBloc>().add(PostNews(
                                description: newsDescController.text.trim(),
                                image: selectedImage,
                                title: newsTitleController.text.trim()));
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
