enum EnumRideStatus{
  created,error,finished,canceled,ongoing,rejected
}

EnumRideStatus enumRideStatusFromString(String status){
  switch(status){
    case "created": return EnumRideStatus.created;
    case "finished": return EnumRideStatus.finished;
    case "canceled": return EnumRideStatus.canceled;
    case "ongoing": return EnumRideStatus.ongoing;
    case "rejected": return EnumRideStatus.rejected;
    default: return EnumRideStatus.error;
  }
}