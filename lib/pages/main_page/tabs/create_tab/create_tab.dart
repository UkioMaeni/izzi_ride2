import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/from_input_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/initial_scene.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {




  @override
  Widget build(BuildContext context) {
          return CreateRideInitialScene();

  }

}