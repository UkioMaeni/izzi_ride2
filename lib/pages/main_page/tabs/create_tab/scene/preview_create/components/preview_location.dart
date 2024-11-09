import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class PreviewLocation extends StatelessWidget {
  const PreviewLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 208
          ),
          decoration: BoxDecoration(
            color: BrandColor.grey244,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              SizedBox(width: 44,),
              R.SVG.WhiteLocation,
              SizedBox(width: 50,),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final createBlocState = context.read<CreateRideBloc>().state;
                    print(createBlocState.fromLocation.state);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 38,),
                        Text(
                          "From",
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 12,
                            color: BrandColor.black,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 60
                          ),
                          child: Text(
                            createBlocState.fromLocation.fullAddress+" - "+createBlocState.fromLocation.stateShort,
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 18,
                              color: BrandColor.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          "To",
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 12,
                            color: BrandColor.black,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 60
                          ),
                          child: Text(
                            createBlocState.toLocation.fullAddress+" - "+createBlocState.toLocation.stateShort,
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 18,
                              color: BrandColor.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(height: 39,)
                      ],
                    );
                  }
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: -0.5,
          right: 12,
          left: 12,
          child: R.SVG.DottedLine,
        )
      ],
    );
  }

  
}