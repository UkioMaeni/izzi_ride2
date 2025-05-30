extension StringFirstUpperCase on String{
  toFirstUpperCace(){
    if(length==1){
      return toUpperCase();
    }
    return this[0].toUpperCase()+substring(1);
  }
}