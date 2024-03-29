import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/profile/bloc/edit_profile_bloc.dart';
import 'package:serophero/features/profile/cubit/image_cubit.dart';
import 'package:serophero/features/profile/cubit/image_cubit_state.dart';
import 'package:serophero/features/profile/data/view_profile_model.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/themes/theme_data.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';

class EditProfile extends StatelessWidget {
  final ViewProfileModel profile;
  EditProfile({super.key, required this.profile});

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController emailAddressController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var listt = profile.userFullname.split(" ");
    firstNameController.text = listt[0];
    lastNameController.text = listt[1];
    userNameController.text = profile.userName;
    addressController.text = profile.userLocation;
    emailAddressController.text = profile.userEmail;
    phoneNumberController.text = profile.userContact;
    String imagepath = profile.userImage;

    File? imageFile;

    List<File>? images;

    String imagesendpath = '';

    Future<List> pickImage(ImageSource source) async {
      final pickedFile = await ImagePicker().pickImage(source: source);
      // print(_imageFile);
      if (pickedFile == null) {
        return [];
      }
      print("Path of file");
      print(pickedFile.path);
      imageFile = File(pickedFile.path);
      imagesendpath = pickedFile.path;
      return [File(pickedFile.path)];
    }

    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Edit Profile'))),
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
                        Text(
                          "Click any fields to edit ",
                          style: small_text_style,
                        ),
                        Icon(Icons.edit, size: 18, color: small_text_color)
                      ],
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<StoreImageCubit, ImageStorage>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () async {
                            List image = await pickImage(ImageSource.gallery);
                            if (image.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("You neeed to add an image")));
                              return;
                            }
                            context
                                .read<StoreImageCubit>()
                                .addition(image: image[0]);
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: profile.userImage != ""
                                  ? state.image == null
                                      ? ClipOval(
                                          child: Image.network(
                                            // state.image!,
                                            AppUrls.baseUrl + imagepath,
                                            cacheHeight: 100,
                                            cacheWidth: 100,
                                            // cacheHeight: 100,
                                            // fit: BoxFit.,
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.file(
                                            state.image!,
                                            cacheHeight: 100,
                                            cacheWidth: 100,
                                            // cacheHeight: 100,
                                            // fit: BoxFit.,
                                          ),
                                        )
                                  : state.image != null
                                      ? ClipOval(
                                          child: Image.file(
                                            state.image!,
                                            cacheHeight: 100,
                                            cacheWidth: 100,
                                            // cacheHeight: 100,
                                            // fit: BoxFit.,
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.network(
                                              cacheHeight: 100,
                                              cacheWidth: 100,
                                              AppUrls.baseUrl +
                                                  "/media/emptyimage/empyt.jpg"),
                                        )),
                        );
                      },
                    ),

                    // Image.network(
                    //   ServerUrl.ipaddress() + imagepath,
                    //   height: 100,
                    // ),
                    // GestureDetector(
                    //   onTap: () {}, //make select image here
                    //   child: CircleAvatar(
                    //       radius: MediaQuery.of(context).size.width / 5,
                    //       backgroundImage: const AssetImage(
                    //           'assets/images/defaults/no_image_user.png')),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                buildTextField(context, "First Name", "FirstName",
                    firstNameController, false),
                buildTextField(context, "Last Name", "Lastname",
                    lastNameController, false),
                buildTextField(
                    context, "Username", "Username", userNameController, false),
                buildTextField(
                    context, "Address", "Address", addressController, false),
                buildTextField(context, "Email Address", "Email Address",
                    emailAddressController, true),
                buildTextField(context, "Phone Number", "Phone Number",
                    phoneNumberController, false),

                profile.businessName != ""
                    ? buildTextField(context, "Business Name", "Business Name",
                        businessNameController, false)
                    : Container(),
                profile.businessName != ""
                    ? buildTextField(context, "Business Description",
                        "Business Description", businessDescController, false)
                    : Container(),

                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         GeneratedRoute().onGeneratedRoute(
                //           const RouteSettings(
                //               arguments: '', name: '/business_registration'),
                //         ));
                //   },
                //   child: Container(
                //     height: 40,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       // shape: BoxShape.circle,
                //       borderRadius: BorderRadius.circular(10),

                //       color: const Color.fromARGB(255, 242, 242,
                //           242), // Replace with your desired background color
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(
                //               0.1), // Adjust shadow color and opacity as needed
                //           spreadRadius: 2,
                //           blurRadius: 6,
                //           offset:
                //               const Offset(0, 2), // Adjust the shadow offset
                //         ),
                //       ],
                //     ),
                //     child: const Center(
                //         child: Text(
                //       "Register a business?",
                //       style: TextStyle(
                //           color: Color.fromRGBO(40, 25, 82, 1),
                //           fontSize: 18,
                //           fontWeight: FontWeight.w500),
                //     )),
                //   ),
                // ),
                const SizedBox(height: 40),
                CustomElevatedButton(
                  text: "Update",
                  onPressed: () {
                    context.read<EditProfileBloc>().add(UpdateProfileEvent(
                        lastname: lastNameController.text.trim(),
                        firstname: firstNameController.text.trim(),
                        contact: phoneNumberController.text.trim(),
                        location: addressController.text.trim(),
                        username: userNameController.text.trim(),
                        image: imageFile,
                        name: businessNameController.text.trim(),
                        description: businessDescController.text.trim()));
                  },
                )
              ],
            ),
          ),
        )));
  }

  Column buildTextField(BuildContext context, String text, String textHint,
      TextEditingController controller, bool? readonly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: edit_profile_heading_style,
        ),
        CustomTextFormField(
          readonly: readonly ?? false,
          hintText: textHint,
          controller: controller,
          context: context,
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
