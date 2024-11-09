import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class CreateDone extends StatefulWidget {
  const CreateDone({super.key});

  @override
  State<CreateDone> createState() => _CreateDoneState();
}

class _CreateDoneState extends State<CreateDone> {

  @override
  void initState() {
    completer();
    super.initState();
  }

  void completer()async{
    await Future.delayed(Duration(seconds: 3));
    context.goNamed(RoutesName.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColor.blue,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.blue,
      ),
      body: Center(
        child: R.SVG.DoneCreateRideIcon,
      )
    );
  }
}