import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';

class CongratiationInstant extends StatelessWidget {
  const CongratiationInstant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Instant booking is included!",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 32,
            color: BrandColor.green,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 32,),
        Text(
          "Now your passengers will receive confirmation immediately after booking.",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 16,
            color: BrandColor.black69,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 32,),
        Text(
          "You will no longer view each request manually.",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 16,
            color: BrandColor.black69,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 148,),
        UIButton(
          label: "Next",
          onTap: (){
            context.read<CreateRideBloc>().add(CreateRideSetAutoInstant(autoInstant: true));
            context.goNamed(RoutesName.createPreview);
          },
        ),
        SizedBox(height: 41,),
      ],
    );
  }
}