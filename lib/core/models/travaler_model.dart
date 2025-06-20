class TravalerModel{
  int id;
  double rate;
  bool hasOrderRate;
  String nickname;
  String avatarUrl;
  String statusName;
  int applicationId;
  String name;
  String surname;
  int numberOfSeats;
  int statusId;
  String bio;
  TravalerModel({
    required this.id,
    required this.rate,
    required this.hasOrderRate,
    required this.nickname,
    required this.avatarUrl,
    required this.statusName,
    required this.applicationId,
    required this.name,
    required this.surname,
    required this.numberOfSeats,
    required this.statusId,
    required this.bio,
  });
}