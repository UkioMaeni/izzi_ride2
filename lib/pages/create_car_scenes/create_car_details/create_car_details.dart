import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';

class CreateCarDetails extends StatefulWidget {
  const CreateCarDetails({super.key});

  @override
  State<CreateCarDetails> createState() => _CreateCarDetailsState();
}

class _CreateCarDetailsState extends State<CreateCarDetails> {


  CreateCarBloc  get createCarBloc => context.read<CreateCarBloc>(); 


  Future<void> createCar()async{
    final result = await UserHttp.I.createUserCar(createCarBloc.state);
    if(result is CustomResponse<bool>){
      await releaseCreateCar();
    }
  }

  releaseCreateCar()async{
    context.read<CarBloc>().add(CarGetInUser());
    context.goNamed(RoutesName.createCar);
  }

  @override
  Widget build(BuildContext context) {
    print(createCarBloc.state.brand.name);
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
                    "Car details",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 24,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          carImage(),
                          SizedBox(height: 16,),
                          Row(
                            children: [
                              Expanded(
                                child: quadratInfo("Car model",createCarBloc.state.fullCarName)
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: quadratInfo("License Plate",createCarBloc.state.carNumber)
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: quadratInfo("Seats Available",createCarBloc.state.seats.toString()+" seats available")
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: SizedBox.shrink()
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  UIButton(
                    label: "Save",
                    onFuture: createCar,
                  ),
                  SizedBox(height: 41,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget quadratInfo(String topTitle,String bottomTitle){
    return Container(
      height: 150,
      padding: EdgeInsets.only(top: 15.5,left: 16,right: 16,bottom: 15.5),
      decoration: BoxDecoration(
        color: BrandColor.grey244,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topTitle,
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 12,
              color: BrandColor.black,
              fontWeight: FontWeight.w400
            ),
          ),
          Text(
            bottomTitle,
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 18,
              color: BrandColor.black,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

  Widget carImage(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Builder(
          builder: (context) {
            
            return Image.network(
              "",
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: BrandColor.grey227,
                );
              },
            );
          }
        ),
      ),
    );
  }

}