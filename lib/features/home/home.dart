import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      // appBar: buildHomeAppBar(context),
      // drawer: Drawer(
      //   width: MediaQuery.of(context).size.width / 1.1,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      //   child: Column(
      //     children: [
      //       Stack(
      //         children: [
      //           ClipPath(
      //             clipper: CustomClipperDesign(),
      //             child: Container(
      //               height: 200,
      //               color: Theme.of(context).colorScheme.primaryContainer,
      //             ),
      //           ),
      //           SafeArea(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [Text("data")],
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  AppBar buildHomeAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image(
                    height: 22,
                    width: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    image: const AssetImage("assets/images/logos/menu.png"),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                "Hi, Shrasta",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Row(
            children: [
              Image(
                height: 28,
                width: 28,
                color: Theme.of(context).colorScheme.tertiary,
                image: const AssetImage("assets/images/logos/search.png"),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    GeneratedRoute().onGeneratedRoute(
                      const RouteSettings(
                        arguments: '',
                        name: '/notification',
                      ),
                    ),
                  );
                },
                child: Image(
                  height: 22,
                  width: 22,
                  color: Theme.of(context).colorScheme.tertiary,
                  image:
                      const AssetImage("assets/images/logos/notification.png"),
                ),
              ),
            ],
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
    );
  }

  // void openDrawer() {
  //   Scaffold.of(context).openDrawer();
  // }
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
