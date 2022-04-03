class Cep {
  String id;
  String state;
  String city;
  String neighborhood;
  String street;
  String long;
  String lat;
  String service;

  Cep({
    required this.id,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.long,
    required this.lat,
    this.service = "correios",
  });
}
