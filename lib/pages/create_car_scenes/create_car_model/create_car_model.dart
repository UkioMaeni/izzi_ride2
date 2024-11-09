import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/car_brand_model_input.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/search_car_brand_and_model.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/debounce.dart';

class CreateCarModel extends StatefulWidget {
  const CreateCarModel({super.key});

  @override
  State<CreateCarModel> createState() => _CreateCarModelState();
}

class _CreateCarModelState extends State<CreateCarModel> {


  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final debouncer = Debounce(duration: Duration(milliseconds: 300));

  CreateCarBloc get createCarBloc => context.read<CreateCarBloc>();

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textEditingController.addListener(listenerByModel);
    super.initState();
  }
  void listenerByModel() => debouncer.debounce(findModel);


  void findModel()async{
    if(textEditingController.text.isEmpty) return;
    final result = await UserHttp.I.getCarModel(textEditingController.text,createCarBloc.state.brand.id);
    if(result is CustomResponse<List<SearchCarBrandAndModel>>){
      setState(() {
        searchList=result.data;
      });
    }
  }

  List<SearchCarBrandAndModel> searchList=[];

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
          NavBar(),
          SizedBox(height: 54,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(),
                  Text(
                    "What is your\nvehicle’s model?",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 24,),
                  CarBrandModelInputUI(
                    controller: textEditingController,
                    focusNode: focusNode,
                  ),
                  SizedBox(height: 32,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return searchedItem(searchList[index]);
                      },
                    )
                  )
                ],
              ),
            ),
          )
          
        ],
      ),
    );
  }

  Widget searchedItem(SearchCarBrandAndModel item){
    return GestureDetector(
      onTap: () {
        createCarBloc.add(CreateCarSelectModel(model: item));
        context.goNamed(RoutesName.createCarSeats);
      },
      child: Container(
        height: 40,
        color: Colors.white,
        padding: EdgeInsets.only(left: 12,right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 18,
                color: BrandColor.black,
                fontWeight: FontWeight.w500
              ),
            ),
            R.SVG.ChevronRightBlack
          ],
        ),
      ),
    );
  }
}