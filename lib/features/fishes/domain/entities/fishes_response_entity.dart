import 'package:fishes/core/enums.dart';
import 'package:fishes/features/fishes/domain/entities/fishes_entity.dart';

class FishResponse {
  List<Fish> fishes;
  ResponseStatus responseStatus;

  FishResponse({
    required this.fishes,
    required this.responseStatus,
  });
}
