import 'package:rickymorty_app/app/data/models/character.dart';

class Episode {
  final String id;
  final String name;
  final String episode;
  final List<Character>? characters;
  final String? created;

  Episode({
    required this.id,
    required this.name,
    required this.episode,
    this.characters,
    this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        name: json["name"],
        episode: json["episode"],
        characters: json["characters"] != null
            ? List<Character>.from(
                json["characters"].map((x) => Character.fromJson(x)))
            : <Character>[],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "episode": episode,
        // "characters": List<dynamic>.from(characters!.map((x) => x.toJson())),
        // "created": created!.toIso8601String(),
      };
}
