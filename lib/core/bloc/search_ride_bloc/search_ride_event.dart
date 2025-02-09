part of 'search_ride_bloc.dart';

abstract class SearchRideEvent{
  const SearchRideEvent();
}

enum Scene{
  initial,
  fromInput,
  fromMap,
  toInput,
  toMap,
  selectDate,
  selectTime,
  selectCar,
  additional
}


class SearchRideEditSearchType extends SearchRideEvent{
  final EnumRideType type;
  const SearchRideEditSearchType({required this.type});
}
class SearchRideSetMapParams extends SearchRideEvent{
  final MapParams mapParams;
  final SceneType type;
  const SearchRideSetMapParams({required this.mapParams,required this.type});
}
class SearchRideSetFromLocation extends SearchRideEvent{
  final Location location;
  const SearchRideSetFromLocation({required this.location});
}
class SearchRideSetToLocation extends SearchRideEvent{
  final Location location;
  const SearchRideSetToLocation({required this.location});
}
class SearchRideEditDate extends SearchRideEvent{
  final DateTime date;
  const SearchRideEditDate({required this.date});
}
class SearchRideEditTime extends SearchRideEvent{
  final TimeOfDay time;
  const SearchRideEditTime({required this.time});
}
class SearchRideEditPersonCounter extends SearchRideEvent{
  final int count;
  const SearchRideEditPersonCounter({required this.count});
}
class SearchRideUpdateFilters extends SearchRideEvent{
  final SearchFilter filters;
  const SearchRideUpdateFilters({required this.filters});
}
class SearchRideUpdateFiltersEditing extends SearchRideEvent{
  final bool isEditing;
  const SearchRideUpdateFiltersEditing({required this.isEditing});
}