import 'package:flutter/material.dart';

class EventsNewsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  // final Function onTap;

  const EventsNewsCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    // required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 3),
                  child: Text(
                    "See all ",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 185,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 1.25,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 195, 174, 239),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width / 1.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, bottom: 6),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NEW YEAR FESTIVAL",
                                  style: TextStyle(
                                    color: Color.fromARGB(133, 255, 255, 255),
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  "The Sanepa ground has been holding a festival for ...",
                                  style: TextStyle(
                                    color: Color.fromARGB(133, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
