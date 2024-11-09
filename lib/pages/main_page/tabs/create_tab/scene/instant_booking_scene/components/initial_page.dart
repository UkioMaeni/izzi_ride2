import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';

class InitialPageInstant extends StatelessWidget {
  final Function() toCongratiation;
  const InitialPageInstant({super.key,required this.toCongratiation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enable Instant booking for your passengers",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 32,
            color: BrandColor.black,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 32,),
        Text(
          "It's Convenient:",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 20,
            color: BrandColor.black,
            fontWeight: FontWeight.w700
          ),
        ),
        Text(
          "You do not need to review each request before confirming it. Passengers can book immediately.",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 16,
            color: BrandColor.black,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 32,),
        Text(
          "More Passengers:",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 20,
            color: BrandColor.black,
            fontWeight: FontWeight.w700
          ),
        ),
        Text(
          "Passengers appreciate the opportunity to receive a response immediately.",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 16,
            color: BrandColor.black,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 32,),
        UIButton(
          label: "Enable Instant Booking",
          onTap: toCongratiation,
        ),
        UIButton(
          reverse: true,
          label: "View each request",
          onTap: () {
            context.read<CreateRideBloc>().add(CreateRideSetAutoInstant(autoInstant: false));
            context.goNamed(RoutesName.createPreview);
          },
        ),
        SizedBox(height: 41,),
      ],
    );
  }
}