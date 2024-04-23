import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/home/bloc/home_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Home({Key? key}) : super(key: key);

  final HomeBloc homebloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homebloc,
        builder: (BuildContext context, HomeState state) {
          if (state is HomeSuccess) {
            return Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: CustomClipperDesign1(),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(55, 15, 0, 0),
                              child: Text("Discover new businesses"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 25, 8, 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.homeData.businesses.map((business) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 150,
                                    width: MediaQuery.of(context).size.width /
                                        1.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(
                                                  0.05), // Shadow color
                                          spreadRadius: 5, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: const Offset(
                                              0, 3), // Offset of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          business.businessName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(business.username),
                                        Text(
                                          business.businessDesc,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upcoming events",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    GeneratedRoute().onGeneratedRoute(
                                      const RouteSettings(
                                          arguments: '', name: '/add_event'),
                                    ));
                              },
                              child: const Text("See all >"))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: state.homeData.events.map((event) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      GeneratedRoute().onGeneratedRoute(
                                        RouteSettings(
                                            arguments: {"event": event},
                                            name: '/view_events'),
                                      ));
                                },
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(
                                                  0.05), // Shadow color
                                          spreadRadius: 5, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: const Offset(
                                              0, 3), // Offset of the shadow
                                        ),
                                      ],
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          event.eventTitle,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(event.eventLocation),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is TokenExpired) {
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(
                  const RouteSettings(arguments: '', name: '/login'),
                ));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Token is Expired'),
              duration: Duration(seconds: 10),
            ));
          }
          if (state is HomeFailure) {
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

          if (state is HomeLoading) {
            Center(child: CircularProgressIndicator());
          }
          homebloc.add(HomePageOpened());

          return ElevatedButton(
            child: Text("Retry"),
            onPressed: () {
              homebloc.add(HomePageOpened());
            },
          );
        },
      ),
    );
  }
}

class CustomClipperDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double w = size.width;
    double h = size.height;

    path.lineTo(0, h / 1.2 - 20);
    path.quadraticBezierTo(20, h / 1.2, 80, h / 1.2);
    path.lineTo(w, h / 1.2);
    path.lineTo(w - 80, h / 1.2);
    path.quadraticBezierTo(w - 20, h - 30, w, h);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomClipperDesign1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double w = size.width;
    double h = size.height;

    path.lineTo(0, h / 1.2 - 80);
    path.quadraticBezierTo(0, h / 1.3, 70, h / 1.3);
    path.lineTo(w, h / 1.3);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
