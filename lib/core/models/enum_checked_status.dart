enum EnumCheckedStatus {
  unconfirmed,pending,confirmed,disabled
}

class CheckedStatusTools{
  static EnumCheckedStatus fromString(String value){
    switch(value){
      case "unconfirmed": return EnumCheckedStatus.unconfirmed;
      case "pending": return EnumCheckedStatus.pending;
      case "confirmed": return EnumCheckedStatus.confirmed;
      default: return EnumCheckedStatus.disabled;
    }
  }
}