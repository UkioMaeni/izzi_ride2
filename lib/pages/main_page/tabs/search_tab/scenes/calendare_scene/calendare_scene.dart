import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/calendare_scene/components/calendare_view.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/time_scene/time_scene.dart';

class SearchCalendareScene extends StatefulWidget {
  const SearchCalendareScene({super.key});

  @override
  State<SearchCalendareScene> createState() => _SearchCalendareSceneState();
}

class _SearchCalendareSceneState extends State<SearchCalendareScene> {
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              print("pop");
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 36),
              height: 50,
              alignment: Alignment.centerLeft,
              child: R.SVG.NavigationBackIcon,
            ),
          ),
          SizedBox(height: 56,),
          Text(
            "Select the date of travel",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 32,
              color: BrandColor.black,
              fontWeight: FontWeight.w700
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CalendareView(),
                  Expanded(child: SizedBox.shrink()),
                  UIButton(
                    label: "Next",
                    onTap: () {
                      context.goNamed(RoutesName.searchTime);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => TimeScene(),));
                    },
                  ),
                  SizedBox(height: 41,)
                ],
              ),
            ),
          )
          

        ],
      ),
    );
  }
}