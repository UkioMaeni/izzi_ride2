import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/car_item_widget.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/additional_options_scene/additional_options_scene.dart';

class SelectCarScene extends StatefulWidget {
  const SelectCarScene({super.key});

  @override
  State<SelectCarScene> createState() => _SelectCarSceneState();
}

class _SelectCarSceneState extends State<SelectCarScene> {


  int selectedCarIndex=0;
  bool carFind=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.goNamed(RoutesName.createTime);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 36),
                height: 50,
                alignment: Alignment.centerLeft,
                child: R.SVG.NavigationBackIcon,
              ),
            ),
            SizedBox(height: 54,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        "Select the car",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 32,
                          color: BrandColor.black69,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Choose the car you want to travel in",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 16,
                          color: BrandColor.black69,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 24,),
                      Builder(
                        builder: (context) {
                          final carBloc=context.watch<CarBloc>();
                          final carBlocState = carBloc.state;
                          if(carBlocState.requsted){
                            return Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()
                                ),
                              )
                            );
                          }
                          if(carBlocState.cars == null){
                            print('find');
                            carBloc.add(CarGetInUser());
                            return Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()
                                ),
                              )
                            );
                          }
                          
                          if(carBlocState.cars!=null && carBlocState.cars!.isEmpty){
                            return Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //context.goNamed(RoutesName.createAdditional,queryParameters: {"backPage":RoutesName.createCar});
                                      context.pushNamed(RoutesName.createCarBrand);
                                    },
                                    child: CarItemWidgetUI.AddCar()
                                  ),
                                ],
                              )
                            );
                          }
                          
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: carBlocState.cars!.length,
                                    itemBuilder: (context, index) {
                                     return Padding(
                                       padding: const EdgeInsets.only(bottom: 8),
                                       child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCarIndex=index;
                                          });
                                        },
                                        child: CarItemWidgetUI(carItem: carBlocState.cars![index],isSelected: selectedCarIndex==index,)
                                      ), 
                                     );
                                    },
                                  )
                                ),
                                UIButton(
                                  label: "Next",
                                  onTap: () {
                                    context.read<CreateRideBloc>().add(CreateRideSetCar(carItem: carBlocState.cars![selectedCarIndex]));
                                    context.goNamed(RoutesName.createAdditional);
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => AdditionalOptionsScene(),));
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                      
                      SizedBox(height: 44,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}