import 'package:fishes/features/fishes/domain/entities/fishes_entity.dart';
import 'package:fishes/utils/format_functions.dart';

class FishDto {
  int id;
  String name, binomialName, conservationStatus, imageUrl;

  FishDto({
    required this.id,
    required this.name,
    required this.binomialName,
    required this.conservationStatus,
    required this.imageUrl,
  });

  factory FishDto.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> metaMap = FormatFunctions.safeParseMap(map['meta']);

    return FishDto(
      id: FormatFunctions.safeParseInt(map['id']),
      name: FormatFunctions.safeParseString(map['name']),
      binomialName: FormatFunctions.safeParseString(metaMap['binomial_name']),
      conservationStatus: FormatFunctions.safeParseString(metaMap['conservation_status']),
      imageUrl: FormatFunctions.safeParseMap(map['img_src_set']).containsKey('2x')
          ? FormatFunctions.safeParseMap(map['img_src_set'])['2x']
          : '',
    );
  }

  Fish toEntity() {
    return Fish(
      id: id,
      name: name,
      binomialName: binomialName,
      conservationStatus: conservationStatus,
      imageUrl: imageUrl,
    );
  }
}
