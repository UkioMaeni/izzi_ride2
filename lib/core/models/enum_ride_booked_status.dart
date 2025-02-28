
enum EnumRideBookedStatus{
  unbooked,pending,accepted,error
}

EnumRideBookedStatus enumRideBookedStatusFromString(String status){
  switch(status){
    case "unbooked": return EnumRideBookedStatus.unbooked;
    case "pending": return EnumRideBookedStatus.pending;
    case "accepted": return EnumRideBookedStatus.accepted;
    default: return EnumRideBookedStatus.error;
  }
}