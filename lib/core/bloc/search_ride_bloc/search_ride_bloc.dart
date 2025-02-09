import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/core/models/enum_scene_type.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/search_filter.dart';

part 'search_ride_state.dart';
part 'search_ride_event.dart';

class SearchRideBloc extends Bloc<SearchRideEvent,SearchRideState>{
  SearchRideBloc():super(SearchRideState.empty()){
    on<SearchRideEditSearchType>((event, emit)async{
      emit(state.copyWith(rideType: event.type));
    });
    on<SearchRideSetMapParams>((event, emit)async{
      if(event.type==SceneType.from){
        emit(state.copyWith(fromMapParams: event.mapParams));
      }else{
        emit(state.copyWith(toMapParams: event.mapParams));
      }
    });
    on<SearchRideSetFromLocation>((event, emit)async{
      emit(state.copyWith(fromLocation: event.location));
    });
    on<SearchRideSetToLocation>((event, emit)async{
      emit(state.copyWith(toLocation: event.location));
    });
    on<SearchRideEditDate>((event, emit)async{
      emit(state.copyWith(date: event.date));
    });
    on<SearchRideEditTime>((event, emit)async{
      emit(state.copyWith(time: event.time));
    });
    on<SearchRideEditPersonCounter>((event, emit)async{
      emit(state.copyWith(personCount: event.count));
    });
    on<SearchRideUpdateFilters>((event, emit)async{
      Map<ECategory, SearchFilter> currentCategoryList=state.filters;
      SearchFilter filter = event.filters;
      bool findCategory=false;
      for(var element in currentCategoryList.entries){
        if(element.key==filter.category){
          findCategory=true;
          break;
        }
      }
      print(findCategory);
      if(findCategory){
        if(currentCategoryList[filter.category]!.value==filter.value){
          currentCategoryList.removeWhere((key, value) => value.value==filter.value,);
        }else{
          currentCategoryList[filter.category]=filter;
        }
        
        
      }else{
        currentCategoryList[filter.category]=filter;
        
      }
      emit(state.copyWith(filters: currentCategoryList));
    });
    on<SearchRideUpdateFiltersEditing>((event, emit)async{
      emit(state.copyWith(filtersEdited: event.isEditing));
    });
  }
  
}