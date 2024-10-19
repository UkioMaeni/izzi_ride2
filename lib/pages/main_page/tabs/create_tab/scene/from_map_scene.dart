import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/google_map_ui.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/debounce.dart';

class FromMapScene extends StatefulWidget {
  const FromMapScene({super.key});

  @override
  State<FromMapScene> createState() => _FromMapSceneState();
}

class _FromMapSceneState extends State<FromMapScene> {

  final debounceTool = Debounce(duration: Duration(milliseconds: 500));

  String fullAddresFromPoint="";

  @override
  Widget build(BuildContext context) {
    final state= context.read<CreateRideBloc>().state;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
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
          Expanded(
            child: Stack(
              children: [
                GoogleMapUi(
                  mapParams: state.mapParams,
                ),
                Positioned(
                  bottom: 44,
                  right: 24,
                  left: 24,
                  child: UIButton(label: "Next",
                    onFuture: ()async {
                      
                    },
                  )
                ),
                Positioned(
                  top: 16,
                  right: 24,
                  left: 24,
                  child: Builder(
                    builder: (context) {
                      if(fullAddresFromPoint.isEmpty){
                              return Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 20,
                                  width: 20, 
                                child: CircularProgressIndicator(color: BrandColor.black,)),
                              );
                            }
                      return Container(
                        constraints: BoxConstraints(
                          minHeight: 32,
                          minWidth: 40
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        alignment: Alignment.center,
                        child:  Text(
                                  state.mapParams.description,
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 12,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                      );
                    }
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}