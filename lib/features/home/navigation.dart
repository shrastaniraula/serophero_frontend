import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom NAV BAR"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          color: Colors.transparent,
          elevation: 40,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          notchMargin: 8,
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(
                //         0.1), // Adjust shadow color and opacity as needed
                //     spreadRadius: 2,
                //     blurRadius: 6,
                //     offset: const Offset(0, 0), // Adjust the shadow offset
                //   ),
                // ],
                color: Theme.of(context).colorScheme.primaryContainer),
          )),
    );
  }
}
