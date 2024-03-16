import 'package:flutter/material.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/business/bloc/directories_bloc.dart';
import 'package:serophero/widgets/custom_search_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';

class Directories extends StatefulWidget {
  const Directories({super.key});

  @override
  State<Directories> createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  final BusinessBloc directoriesbloc = BusinessBloc();

  @override
  void initState() {
    directoriesbloc.add(DirectoriesPageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Business Directory")),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(
            children: [
              CustomSearchView(
                hintText: "Search for people",
                context: context,
              ),
              Container(
                child: BlocBuilder<BusinessBloc, BusinessState>(
                  bloc: directoriesbloc,
                  builder: (BuildContext context, BusinessState state) {
                    if (state is TokenExpired) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Token is Expired'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      });
                    } else if (state is DirectoriesFailure) {
                      if (mounted) {
                        // Show SnackBar using ScaffoldMessenger outside the build method
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        });
                      }
                    } else if (state is DirectoriesSuccess) {
                      return Column(
                        children: state.directorieslist.map((directories) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        GeneratedRoute().onGeneratedRoute(
                                          RouteSettings(arguments: {
                                            "userId": directories.userId
                                          }, name: '/view_profile'),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 25,
                                            backgroundImage: directories
                                                        .userImage !=
                                                    ""
                                                ? NetworkImage(
                                                    "${AppUrls.baseUrl}/media/${directories.userImage}")
                                                : const AssetImage(
                                                        'assets/images/defaults/no_image_user.png')
                                                    as ImageProvider<Object>),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              directories.username,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              directories.userType,
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          GeneratedRoute().onGeneratedRoute(
                                            const RouteSettings(
                                                arguments: '',
                                                name: '/chat_page'),
                                          ));
                                    },
                                    child: Image(
                                      height: 22,
                                      width: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      image: const AssetImage(
                                          "assets/logos/chat_filled.png"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
