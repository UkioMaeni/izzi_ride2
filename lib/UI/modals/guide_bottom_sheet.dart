import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';

enum EUIGuideBottomSheetType{
  location
}


class UIGuideBottomSheet extends StatelessWidget {
  final EUIGuideBottomSheetType type;
  const UIGuideBottomSheet({super.key,required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 800,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(
                    "Guide",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 25,
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        // базовый стиль (по умолчанию унаследует DefaultTextStyle)
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 22,
                          color: BrandColor.black69,
                          fontWeight: FontWeight.w800
                        ),
                        children: [
                          TextSpan(text: 'Title: '),
                          TextSpan(
                            text: 'Stream location',
                            style: TextStyle(color: BrandColor.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Text(
                    "For use ajnksdfnjka jnkas ndjkajknd nasjkd nakjdn akjnnkdj akjnd jnk jnkasjnkd njkanjkd jkans njkasjnkd ad",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 22,
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w400
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: UIButton(label: "Stream location",height: 50,),
                  ),
                  Text(
                    "For use ajnksdfnjka jnkas ndjkajknd nasjkd nakjdn akjnnkdj akjnd jnk jnkasjnkd njkanjkd jkans njkasjnkd ad",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 22,
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w400
                    ),
                    
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 100
                      ),
                      decoration: BoxDecoration(
                        color: BrandColor.grey214,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      //alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "vk.com/dsadaasdasdasdad255",
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 16,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.copy,color: BrandColor.black69,size: 20,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}