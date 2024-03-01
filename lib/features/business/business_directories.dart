import 'package:flutter/material.dart';
import 'package:serophero/widgets/custom_search_view.dart';

class Directories extends StatefulWidget {
  const Directories({super.key});

  @override
  State<Directories> createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: const Icon(
            //         Icons.arrow_back,
            //       ),
            //     ),
            const Center(
          child: Text(
            "Business Directory",
            style: TextStyle(fontSize: 18),
          ),
        ),
        //     const SizedBox()
        //   ],
        // ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          children: [
            CustomSearchView(
              hintText: "Search for people",
              context: context,
            )
          ],
        ),
      )),
    );
  }
}
