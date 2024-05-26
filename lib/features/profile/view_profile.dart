import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/profile/bloc/view_profile_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ViewProfile extends StatefulWidget {
  final int userId;

  const ViewProfile({super.key, required this.userId});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final ViewProfileBloc viewprofilebloc = ViewProfileBloc();

  @override
  void initState() {
    viewprofilebloc.add(ProfilePageOpened(user: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewProfileBloc, ViewProfileState>(
      bloc: viewprofilebloc,
      builder: (BuildContext context, ViewProfileState state) {
        if (state is TokenExpired) {
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('Token is Expired'),
          //   duration: Duration(seconds: 1),
          // ));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Token is expired'),
                duration: Duration(seconds: 1),
              ),
            );
          });
        } else if (state is ViewProfileFailure) {
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  duration: const Duration(seconds: 1),
                ),
              );
            });
          }
        } else if (state is ViewProfileSuccess) {
          return Scaffold(
            appBar: AppBar(title: const Center(child: Text('View Profile'))),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 70,
                              backgroundImage: state.user_data.userImage != ""
                                  ? NetworkImage(
                                      '${AppUrls.baseUrl}${state.user_data.userImage}')
                                  : const AssetImage(
                                          'assets/images/defaults/no_image_user.png')
                                      as ImageProvider<Object>),
                          const SizedBox(height: 05),
                          Text(
                            state.user_data.userFullname,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            state.user_data.userName != ""
                                ? "@${state.user_data.userName}"
                                : "",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          child: Center(
                            child: Text(
                              state.user_data.userType == "business"
                                  ? "Business User"
                                  : state.user_data.userType == "authority"
                                      ? "Authority User"
                                      : "Normal User",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                GeneratedRoute().onGeneratedRoute(
                                  RouteSettings(arguments: {
                                    "userId": state.user_data.userId
                                  }, name: '/chat_page'),
                                ));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 7.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: Center(
                              child: Image(
                                  height: 22,
                                  width: 22,
                                  color: Theme.of(context).colorScheme.tertiary,
                                  image: const AssetImage(
                                      "assets/logos/chat_filled.png")),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                GeneratedRoute().onGeneratedRoute(
                                  RouteSettings(arguments: {
                                    'id': state.user_data.userId,
                                    'type': 'user'
                                  }, name: '/report'),
                                ));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 7.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: const Center(
                              child: Icon(Icons.report_problem_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text("Lives in"),
                      subtitle: Text(state.user_data.userLocation),
                    ),
                    ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text("Contact number"),
                        subtitle: Text(state.user_data.userContact),
                        onTap: () async {
                          try {
                            var number = state.user_data.userContact;
                            await FlutterPhoneDirectCaller.callNumber(number);
                          } catch (e) {
                            print(e);
                          }
                        }),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Email address"),
                      subtitle: Text(state.user_data.userEmail),
                    ),
                    state.user_data.userType != "normal"
                        ? ListTile(
                            leading: const Icon(Icons.work),
                            title: const Text("Works at"),
                            subtitle: Text(state.user_data.businessName != ""
                                ? state.user_data.businessName
                                : state.user_data.authorityType),
                          )
                        : const Text(""),
                    // const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
