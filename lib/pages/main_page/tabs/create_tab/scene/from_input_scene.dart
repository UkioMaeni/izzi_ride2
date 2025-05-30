import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:googlemaps_flutter_webservices/places.dart';
import 'package:izzi_ride_2/UI/from_to_input.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/enum_scene_type.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/resources/image_widgets.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/resources/svg_widgets.dart';
import 'package:izzi_ride_2/core/tools/debounce.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/from_map_scene.dart';

class FromInputScene extends StatefulWidget {

  const FromInputScene({
    super.key,
  });

  @override
  State<FromInputScene> createState() => _FromInputSceneState();
}

class _FromInputSceneState extends State<FromInputScene> {

  final TextEditingController _controller=TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final debounceTool = Debounce(duration: Duration(milliseconds: 500));

  @override
  void initState() {
    _controller.addListener((){
      debounceTool.debounce(getCity);
    });
    super.initState();
  }

  List<Prediction> _cityList = [];

  void getCity()async{
    if(_controller.text.isEmpty){
      setState(() {
        _cityList=[];
      });
      return;
    }
    log("request");
    final result =await UserHttp().getCityFromGoogle(_controller.text);
    inspect(result);
    if(result is CustomResponse<List<Prediction>>){
      setState(() {
        _cityList=result.data;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 8,),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 24,),
                FromToInputUI(
                  controller: _controller,
                  focusNode: _focusNode,
                  type: SceneType.from,
                ),
                SizedBox(
                  height: 66*5,
                  child: ListView.builder(
                    itemCount: _cityList.length,
                    itemBuilder: (context, index) {
                      return cityElement(index);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  int variableIndex=-1;
  bool isLockTaped=false;

  Future<void> getMapParams(String placeId,String description)async{
    isLockTaped=true;
    final result = await UserHttp().getMapParamsFromGoogle(placeId,description);
    if(result is CustomResponse<MapParams>){
      setMapParams(result.data);
      toMapScene();
    }
    isLockTaped=false;
    variableIndex=-1;
    setState(() {});
  }

  toMapScene(){
    context.goNamed(RoutesName.createFromMap);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => FromMapScene(),));
  }

  setMapParams(MapParams mapParams){
    context.read<CreateRideBloc>().add(CreateRideSetMapParams(mapParams: mapParams,type: SceneType.from));
  }

  Widget cityElement(int index){
    List<String> _description= _cityList[index].description!.split(",");

    return  GestureDetector(
      onTap: () {
        if(isLockTaped) return;
        getMapParams(
          _cityList[index].placeId!,
          _cityList[index].description??""
        );
        variableIndex=index;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: BrandColor.grey167
            )
          )
        ),
                height: 66,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _description[0],
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 18,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            "${_description[2]}, ${_description[1]}",
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 12,
                              color: BrandColor.grey167,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: 
                        variableIndex==index
                          ?SizedBox(width: 17,height: 17, child: CircularProgressIndicator(color: BrandColor.black69,strokeWidth: 2,))
                          :R.SVG.ChevronRight,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 22),
                    )
                  ],
                )
      
              ),
    );
  }

}