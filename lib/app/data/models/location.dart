import 'package:rickymorty_app/app/data/models/character.dart';

class Location {
  final String? id;
  final String name;
  final String? type;
  final String? dimension;
  final String? created;
  final List<Character>? residents;

  Location({
    this.id,
    required this.name,
    this.type,
    this.dimension,
    this.created,
    this.residents,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"] ?? '',
        name: json["name"],
        type: json["type"] != null ? json['type'] : '',
        dimension: json["dimension"] != null ? json['dimension'] : '',
        created: json["created"] != null ? json['created'] : '',
        residents: json["residents"] != null
            ? List<Character>.from(
                json["residents"].map((x) => Character.fromJson(x)))
            : <Character>[],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "created": created,
        "residents": List<dynamic>.from(residents!.map((x) => x.toJson())),
      };
}
