import 'package:flutter/material.dart';

class homescreenprc extends StatefulWidget {


  @override
  State<homescreenprc> createState() => _homescreenprcState();
}

class _homescreenprcState extends State<homescreenprc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("View Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
