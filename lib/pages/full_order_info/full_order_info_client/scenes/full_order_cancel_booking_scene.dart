import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class FullOrderCancelBookingScene extends StatefulWidget {
  const FullOrderCancelBookingScene({super.key});

  @override
  State<FullOrderCancelBookingScene> createState() => _FullOrderCancelBookingSceneState();
}

class _FullOrderCancelBookingSceneState extends State<FullOrderCancelBookingScene> {


  @override
  void initState() {
    //completer();
    super.initState();
  }

  void completer()async{
    await Future.delayed(Duration(seconds: 2));
    context.read<AppInformationBloc>().add(AppInformationSetIalTabPage(page: 1));
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
        child: R.Image.IllustrtationDriverAway,
      )
    );
  }
}