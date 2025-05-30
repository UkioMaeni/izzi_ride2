class CarItem{
  int carId;
  String brand;
  String model;
  String color;
  List<String>? imageUrl;
  int seats;
  String year;
  String number;
  CarItem({
    required this.carId,
    required this.brand,
    required this.model,
    required this.color,
    required this.seats,
    required this.year,
    this.imageUrl,
    required this.number
  });
}