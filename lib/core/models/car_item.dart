class CarItem{
  int carId;
  String brand;
  String model;
  String color;
  String? imageUel;
  int seats;
  String year;
  CarItem({
    required this.carId,
    required this.brand,
    required this.model,
    required this.color,
    required this.seats,
    required this.year,
    this.imageUel,
  });
}