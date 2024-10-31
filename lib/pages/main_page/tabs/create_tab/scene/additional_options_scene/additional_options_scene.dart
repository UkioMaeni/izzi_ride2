import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/additional_options_scene/components/additional_item.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/additional_options_scene/components/comment_area.dart';

class AdditionalOptionsScene extends StatefulWidget {
  const AdditionalOptionsScene({super.key});

  @override
  State<AdditionalOptionsScene> createState() => _AdditionalOptionsSceneState();
}

class _AdditionalOptionsSceneState extends State<AdditionalOptionsScene> {

  final FocusNode _focusNode = FocusNode();

  bool isFocused=false;

  @override
  void initState() {
    _focusNode.addListener((){
      setState(() {
        if(_focusNode.hasFocus){
          isFocused=true;
        }else{
          isFocused=false;
        }
      });
    });
    super.initState();
  }

  @override
    void dispose() {
      _focusNode.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
            child: Column(
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
                SizedBox(height: 57,),
                 Expanded(
                   child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Builder(
                        builder: (context) {
                          final createBloc= context.watch<CreateRideBloc>();
                          final stateCreateBloc = createBloc.state;
                          return Column(
                              children: [
                                AdditionalItem(
                                  title: "Luggage",
                                  isSelected: stateCreateBloc.additional.luggage,
                                  onChangeSelected: (selected) {
                                    Additional additional = stateCreateBloc.additional;
                                    createBloc.add(CreateRideEditAdditional(additional:additional.copyWith(luggage: selected)));
                                  },
                                ),
                                SizedBox(height: 8,),
                                AdditionalItem(
                                  title: "Baby chaire",
                                  isSelected: stateCreateBloc.additional.babyChaire,
                                  onChangeSelected: (selected) {
                                    Additional additional = stateCreateBloc.additional;
                                    createBloc.add(CreateRideEditAdditional(additional:additional.copyWith(babyChaire: selected)));
                                  },
                                ),
                                SizedBox(height: 8,),
                                AdditionalItem(
                                  title: "Animals",
                                  isSelected: stateCreateBloc.additional.animals,
                                  onChangeSelected: (selected) {
                                    Additional additional = stateCreateBloc.additional;
                                    createBloc.add(CreateRideEditAdditional(additional:additional.copyWith(animals: selected)));
                                  },
                                ),
                                SizedBox(height: 8,),
                                AdditionalItem(
                                  title: "Smoking",
                                  isSelected: stateCreateBloc.additional.smoking,
                                  onChangeSelected: (selected) {
                                    Additional additional = stateCreateBloc.additional;
                                    createBloc.add(CreateRideEditAdditional(additional:additional.copyWith(smoking: selected)));
                                  },
                                ),
                                SizedBox(height: 71,),
                                CommentArea(
                                  focusNode: _focusNode,
                                  isFocused:isFocused,
                                  onTextChange: (value) {
                                    context.read<CreateRideBloc>().add(CreateRideEditComment(comment: value));
                                  },
                                ),
                                Expanded(child: SizedBox.shrink()),
                                UIButton(
                                  label: "Next",
                                  onTap: () {
                                    context.goNamed(RoutesName.createPrice);
                                  },
                                ),
                                SizedBox(height: 44,)
                              ],
                            );
                        }
                      ),
                      
                    
                                   ),
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}