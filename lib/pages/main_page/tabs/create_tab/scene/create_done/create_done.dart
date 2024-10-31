import 'package:flutter/material.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class CreateDone extends StatefulWidget {
  const CreateDone({super.key});

  @override
  State<CreateDone> createState() => _CreateDoneState();
}

class _CreateDoneState extends State<CreateDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 36),
                height: 50,
                alignment: Alignment.centerLeft,
                child: R.SVG.NavigationBackIcon,
              ),
              
          ),
        ],
      ),
    );
  }
}