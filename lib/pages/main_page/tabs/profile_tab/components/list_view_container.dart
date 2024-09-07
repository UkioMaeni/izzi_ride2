import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/list_item.dart';

class ListViewContainer extends StatelessWidget {
  final List<ListItem> items;
  final String? title;
  const ListViewContainer({super.key,required this.items,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(
          builder: (context) {
            if(title!=null){
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 42,
                padding: EdgeInsets.only(left: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                    title!,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 20,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        Container(
          decoration: BoxDecoration(
            color: BrandColor.listViewContainer,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              for(var element in items )
              element
            ],
          ),
        ),
      ],
    );
  }
}