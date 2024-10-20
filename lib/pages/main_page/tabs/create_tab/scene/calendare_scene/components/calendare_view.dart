import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, WeekdayFormat;
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
class CalendareView extends StatefulWidget {
  const CalendareView({super.key});

  @override
  State<CalendareView> createState() => _CalendareViewState();
}

class _CalendareViewState extends State<CalendareView> {



  late String _currentMonth;
  late DateTime _selectedDate;
  
  @override
  void initState() {
    _currentMonth=DateFormat("MMMM y").format(DateTime.now());
    _selectedDate=DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 16.0),
//     child: CalendarCarousel<Event>(
//       onDayPressed: (DateTime date, List<Event> events) {
//         //this.setState(() => _currentDate = date);
//       },
//       weekendTextStyle: TextStyle(
//         color: Colors.red,
//       ),
//       thisMonthDayBorderColor: Colors.grey,
// //      weekDays: null, /// for pass null when you do not want to render weekDays
// //      headerText: Container( /// Example for rendering custom header
// //        child: Text('Custom Header'),
// //      ),
//       customDayBuilder: (   /// you can provide your own build function to make custom day containers
//         bool isSelectable,
//         int index,
//         bool isSelectedDay,
//         bool isToday,
//         bool isPrevMonthDay,
//         TextStyle textStyle,
//         bool isNextMonthDay,
//         bool isThisMonthDay,
//         DateTime day,
//       ) {
//           /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
//           /// This way you can build custom containers for specific days only, leaving rest as default.

//           // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
//           if (day.day == 15) {
//             return Center(
//               child: Icon(Icons.local_airport),
//             );
//           } else {
//             return null;
//           }
//       },
//       weekFormat: false,
//       //markedDatesMap: _markedDateMap,
//       height: 420.0,
//       selectedDateTime: _selectedDate,
//       daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
//     ),
//   );

    return Column(
      children: [
        SizedBox(height: 69,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
                _currentMonth =DateFormat("MMMM y").format(_selectedDate);
                setState(() {});
              },
              child: Transform.rotate(angle: pi,child: R.SVG.ChevronRightBlack,)
            ),
            Container(
              width: 233,
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  return Text(
                    _currentMonth,
                    style: TextStyle(
                      color:BrandColor.black,
                      fontFamily: BrandFontFamily.platform,
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  );
                }
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
                _currentMonth =DateFormat("MMMM y").format(_selectedDate);
                setState(() {});
              },
              child: R.SVG.ChevronRightBlack
            ),
          ],
        ),
        SizedBox(height: 41,),
        CalendarCarousel<Event>(
          todayBorderColor: Colors.transparent,
          minSelectedDate: DateTime.now().subtract(Duration(days: 1)),
          onDayPressed: (date, events) {
            if(date.isBefore(DateTime.now())){
              print(date.microsecondsSinceEpoch);
              print(DateTime.now().microsecondsSinceEpoch);
              setState(() {
                //_selectedDate=DateTime.now();
              });
              return;
            }
            final d=date.toUtc().millisecondsSinceEpoch ~/ 1000;
            print(d);
             setState(() {
             // _selectedDate = date;
              //_currentMonth = DateFormat("MMMM y").format(date);
            });
          },
          weekDayPadding: EdgeInsets.only(bottom: 10),
          weekDayMargin: EdgeInsets.zero,
          daysHaveCircularBorder: false,
          customDayBuilder: (isSelectable, index, isSelectedDay, isToday, isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {
            return InkWell(
              splashColor: Colors.amber,
              highlightColor: Colors.transparent,
              child: Ink(
                height: 44,
                width: 44,
                child: Container(
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:isSelectedDay? BrandColor.blue:Colors.transparent,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      color: isSelectedDay?Colors.white: BrandColor.black,
                      fontFamily: "SF",
                      fontWeight: FontWeight.w400,
                      fontSize: 20
                    ),
                    ),
                ),
              ),
            );
          },
          showOnlyCurrentMonthDate: true,
          selectedDateTime: _selectedDate,
          weekdayTextStyle: TextStyle(
            color: BrandColor.black,
            fontFamily: "SF",
            fontWeight: FontWeight.w600,
            fontSize: 13
          ),
          weekendTextStyle: TextStyle(
            color: BrandColor.black,
          ),
          weekDayFormat:WeekdayFormat.narrow,
          thisMonthDayBorderColor: Colors.transparent,
          weekFormat: false,
          height: 300,
        //      firstDayOfWeek: 4,
          customGridViewPhysics: NeverScrollableScrollPhysics(),
          onCalendarChanged: (DateTime date) {
            
            if(date.month!=_selectedDate.month){
              print(false);
                setState(() {
              _selectedDate = DateTime.now();
              _currentMonth = DateFormat("MMMM y").format(date);
            });
            }
            
          },
          showHeader: false,
          todayTextStyle: TextStyle(
            color: BrandColor.black
          ),
          
          // markedDateShowIcon: true,
          // markedDateIconMaxShown: 2,
          // markedDateIconBuilder: (event) {
          //   return event.icon;
          // },
          // markedDateMoreShowTotal:
          //     true,
          todayButtonColor: Colors.transparent,
          selectedDayTextStyle: TextStyle(
            color: Colors.white,
          ),
          targetDateTime: _selectedDate,
          selectedDayButtonColor: Colors.transparent,
          selectedDayBorderColor: Colors.transparent,
          dayPadding: 4,
          
          prevDaysTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.transparent,
        
          ),
          nextDaysTextStyle: TextStyle(
            color: Colors.amber
          ),
          inactiveDaysTextStyle: TextStyle(
            color: BrandColor.blue,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}