enum EnumRideStatus{
  created,error
}

EnumRideStatus enumRideStatusFromString(String status){
  switch(status){
    case "created": return EnumRideStatus.created;
    default: return EnumRideStatus.error;
  }
}