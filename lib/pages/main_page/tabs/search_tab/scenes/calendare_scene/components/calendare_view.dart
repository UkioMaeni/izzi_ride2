import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, WeekdayFormat;
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
class SearchRideCalendareView extends StatefulWidget {
  const SearchRideCalendareView({super.key});

  @override
  State<SearchRideCalendareView> createState() => _SearchRideCalendareViewState();
}

class _SearchRideCalendareViewState extends State<SearchRideCalendareView> {



  
  @override
  void initState() {
    
    super.initState();
  }

  DateTime get currentDate=>DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final searchRideBloc = context.watch<SearchRideBloc>();
        final searchRideBlocState = searchRideBloc.state;
        final _selectedDate=searchRideBlocState.date;
        final _currentMonth=DateFormat("MMMM y").format(_selectedDate);
        return Column(
          children: [
            SizedBox(height: 69,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    DateTime newDate =  DateTime(_selectedDate.year, _selectedDate.month - 1);
                    // print(_selectedDate);
                    // print(newDate);
                    // print(currentDate.isBefore(_selectedDate));
                    if(currentDate.isBefore(_selectedDate)){
                      print(_selectedDate.month==currentDate.month);
                      if(newDate.month==currentDate.month && newDate.year==currentDate.year){
                        //print(false);
                        setState(() {
                          searchRideBloc.add(SearchRideEditDate(date: currentDate));
                          //_currentMonth = DateFormat("MMMM y").format(_selectedDate);
                        });
                        
                      }else{
                        searchRideBloc.add(SearchRideEditDate(date: newDate));
                        //_selectedDate=newDate;
                        //_currentMonth =DateFormat("MMMM y").format(_selectedDate);
                      }
                      
                      setState(() {});
                    }
                    
                    
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
                    DateTime newDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
                    searchRideBloc.add(SearchRideEditDate(date: newDate));
                    
                    //_currentMonth =DateFormat("MMMM y").format(_selectedDate);
                    //setState(() {});
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
                
                if(date.isAfter(currentDate)){
                  searchRideBloc.add(SearchRideEditDate(date: date));
                }
              },
              weekDayPadding: EdgeInsets.only(bottom: 10),
              weekDayMargin: EdgeInsets.zero,
              daysHaveCircularBorder: false,
              //dayButtonColor: Colors.transparent,
              disableDayPressed: true,

              customDayBuilder: (isSelectable, index, isSelectedDay, isToday, isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {
                if(isSelectable){
                  //print(day.day.toString());
                }
                return  GestureDetector(
                  onTap: () {
                    //print(DateTime.now());
                    if(isSelectable){
                      searchRideBloc.add(SearchRideEditDate(date: day));
                    }
                  },
                  child: SizedBox(
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
                            color: isSelectedDay?Colors.white:isSelectable? BrandColor.black:BrandColor.black.withAlpha(100),
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
              pageScrollPhysics: NeverScrollableScrollPhysics(),
              onCalendarChanged: (DateTime date) {
                //print(date);
                
                
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
    );
  }
}