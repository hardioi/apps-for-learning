import 'package:di_clean_architecture_solid/feature/data/models/location_model.dart';
import 'package:di_clean_architecture_solid/feature/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required id,
    required name,
    required status,
    required species,
    required type,
    required gender,
    required origin,
    required location,
    required image,
    required episode,
    required created,
  }) : super(
          id: id,
          name: name,
          created: created,
          episode: episode,
          gender: gender,
          image: image,
          location: location,
          origin: origin,
          species: species,
          status: status,
          type: type,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin'] != null
          ? LocationModel.fromJson(json['origin'])
          : null,
      location: json['origin'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      image: json['image'],
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episode,
      'creared': created.toIso8601String(),
    };
  }
}
