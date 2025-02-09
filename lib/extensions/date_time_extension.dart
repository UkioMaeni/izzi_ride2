extension DateTimeExtension on DateTime{
  String toIZZIRIDEFORMAT(){
    String _year=year.toString();
    String _month=month<10?"0$month":month.toString();
    String _day=day<10?"0$day":day.toString();
    String _hour=hour<10?"0$hour":hour.toString();
    String _minute=minute<10?"0$minute":minute.toString();
    String _second=second<10?"0$second":second.toString();
    String _hourOffset=
      timeZoneOffset.inHours<10&&timeZoneOffset.inHours>=0?"0"+timeZoneOffset.inHours.toString():
      timeZoneOffset.inHours<0&&timeZoneOffset.inHours>-10?"-0"+timeZoneOffset.inHours.abs().toString():
      timeZoneOffset.inHours.toString();
    String _minuteOffset="00";
    String formattedDate=
      _year+"-"+_month+"-"+_day+" "+_hour+":"+_minute+":"+_second;
    return formattedDate;
  }
}

