import 'package:fishes/features/fishes/domain/entities/fishes_response_entity.dart';

abstract class FishesRepository {
  Future<FishResponse> getFishes(String search);
}
