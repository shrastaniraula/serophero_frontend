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
import 'package:serophero/features/home/bloc/home_bloc.dart';
import 'package:serophero/widgets/snackbar.dart';

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
    businessNameController.text = profile.businessName;
    businessDescController.text = profile.businessDescription;

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
                                              "${AppUrls.baseUrl}/media/emptyimage/no_image_user.png"),
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
                buildTextField(context, "Firstname", "enter a firstname",
                    firstNameController, false),
                buildTextField(context, "Lastname", "enter a lastname",
                    lastNameController, false),
                buildTextField(context, "Username", "enter a username",
                    userNameController, false),
                buildTextField(context, "Address", "enter an address",
                    addressController, false),
                buildTextField(context, "Email Address", "enter an email",
                    emailAddressController, true),
                buildTextField(context, "Phone Number", "enter a phone number",
                    phoneNumberController, false),
                profile.businessName != ""
                    ? buildTextField(context, "Business Name", "Business Name",
                        businessNameController, false)
                    : Container(),
                profile.businessName != ""
                    ? buildTextField(context, "Business Description",
                        "Business Description", businessDescController, false)
                    : Container(),
                const SizedBox(height: 20),
                Center(
                  child: CustomElevatedButton(
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

                      final HomeBloc homebloc = HomeBloc();
                      homebloc.add(HomePageOpened());

                      MySnackbar.show(
                        context,
                        title: "Profile Updated Successfully",
                        message: "Your profile has been updated successfully.",
                        type: SnackbarType.success,
                      );

                      Navigator.push(
                          context,
                          GeneratedRoute().onGeneratedRoute(
                            RouteSettings(name: '/home'),
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 40),
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
