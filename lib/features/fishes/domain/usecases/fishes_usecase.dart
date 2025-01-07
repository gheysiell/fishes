import 'package:fishes/features/fishes/domain/entities/fishes_response_entity.dart';
import 'package:fishes/features/fishes/domain/repositories/fishes_repository.dart';

class FishesUseCase {
  FishesRepository fishesRepository;

  FishesUseCase({
    required this.fishesRepository,
  });

  Future<FishResponse> getFishes(String search) async {
    return await fishesRepository.getFishes(search);
  }
}
