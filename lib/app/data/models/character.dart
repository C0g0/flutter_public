import 'package:rickymorty_app/app/data/models/location.dart';

class Character {
  final String id;
  final String name;
  final String image;
  final String? status;
  final String? species;
  final Location? location;
  final Location? origin;
  final String? gender;

  Character({
    required this.id,
    required this.name,
    required this.image,
    this.gender,
    this.status,
    this.species,
    this.location,
    this.origin,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"] ?? '',
        species: json["species"] ?? '',
        location: json["location"] != null
            ? Location.fromJson(json["location"])
            : Location(name: '', id: ''),
        origin: json["origin"] != null
            ? Location.fromJson(json["origin"])
            : Location(name: '', id: ''),
        image: json["image"],
        gender: json["gender"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "location": location!.toJson(),
        "origin": origin!.toJson(),
        "image": image,
        "gender": gender,
      };
}
