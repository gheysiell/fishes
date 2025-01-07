import 'package:fishes/core/enums.dart';
import 'package:fishes/features/fishes/data/dtos/fishes_dto.dart';
import 'package:fishes/features/fishes/domain/entities/fishes_response_entity.dart';

class FishResponseDto {
  List<FishDto> fishesDto = [];
  ResponseStatus responseStatus;

  FishResponseDto({
    required this.fishesDto,
    required this.responseStatus,
  });

  FishResponse toEntity() {
    return FishResponse(
      fishes: fishesDto.map((fishDto) => fishDto.toEntity()).toList(),
      responseStatus: responseStatus,
    );
  }
}
