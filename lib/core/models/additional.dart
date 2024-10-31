class Additional{
  bool luggage = false;
  bool babyChaire = false;
  bool animals = false;
  bool smoking = false;

  Additional copyWith({
    bool? luggage,
    bool? babyChaire,
    bool? animals,
    bool? smoking,
  }){
    return Additional()
      ..luggage=luggage??this.luggage
      ..babyChaire=babyChaire??this.babyChaire
      ..animals=animals??this.animals
      ..smoking=smoking??this.smoking;
  }
}