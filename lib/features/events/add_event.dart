import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/business/bloc/directories_bloc.dart';
import 'package:serophero/features/events/bloc/event_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:serophero/widgets/snackbar.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime selectedDate = DateTime.now();
  DateTime eventTime = DateTime.now();

  final BusinessBloc directoriesBloc = BusinessBloc();
  List<dynamic> selectedUserIds = [];
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();

  @override
  void initState() {
    directoriesBloc.add(DirectoriesPageOpened());
    super.initState();
  }

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Add Events"))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<BusinessBloc, BusinessState>(
                bloc: directoriesBloc,
                builder: (context, state) {
                  if (state is DirectoriesSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Select User",
                            style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary)),
                        const SizedBox(height: 10),
                        MultiSelectDialogField(
                          title: Text(
                            "Select who can view",
                            style: TextStyle(fontSize: 20),
                          ),
                          buttonIcon: const Icon(Icons.search),
                          searchIcon: const Icon(
                            Icons.search,
                            size: 20,
                          ),
                          chipDisplay: MultiSelectChipDisplay(
                            chipColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            scroll: true,
                          ),
                          confirmText: const Text("Okay"),
                          cancelText: const Text("Cancel"),
                          searchable: true,
                          separateSelectedItems: true,
                          // barrierColor: Colors.amber,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          items: state.directorieslist
                              .map((e) => MultiSelectItem(e.userId, e.username))
                              .toList(),
                          listType: MultiSelectListType.LIST,
                          onConfirm: (values) {
                            selectedUserIds = values;
                          },
                        ),
                      ],
                    );
                  } else if (state is DirectoriesFailure) {
                    return const Center(child: Text("Failed to load users"));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: "Event Heading",
                controller: eventTitleController,
                context: context,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Description",
                controller: eventDescController,
                context: context,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: "Location",
                controller: eventLocationController,
                context: context,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: eventDateController,
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                onTap: () => _selectDate(context),
                readOnly: true,
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
                child: CustomElevatedButton(
                    text: "Submit",
                    backgroundColorBtn: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      print(selectedUserIds);
                      context.read<EventBloc>().add(PostEvents(
                          eventDescription: eventDescController.text.trim(),
                          image: selectedImage,
                          eventHeading: eventTitleController.text.trim(),
                          eventLocation: eventLocationController.text.trim(),
                          eventTime: eventTime,
                          allowed: selectedUserIds));

                      MySnackbar.show(
                        context,
                        title: "Event Posted Successfully",
                        message:
                            "Your event can be seen by users who you've given access to.",
                        type: SnackbarType.success,
                      );

                      Navigator.push(
                          context,
                          GeneratedRoute().onGeneratedRoute(
                            RouteSettings(name: '/home'),
                          ));
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        eventDateController.text = _picked.toString().split(" ")[0];
        eventTime = _picked;
      });
    }
  }
}
