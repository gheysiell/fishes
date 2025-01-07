import 'package:fishes/core/enums.dart';
import 'package:fishes/features/fishes/domain/entities/fishes_entity.dart';
import 'package:fishes/features/fishes/domain/entities/fishes_response_entity.dart';
import 'package:fishes/features/fishes/domain/usecases/fishes_usecase.dart';
import 'package:fishes/utils/functions.dart';
import 'package:flutter/material.dart';

class FishesViewModel extends ChangeNotifier {
  List<Fish> fishes = [];
  bool loading = false;
  bool searching = false;
  FishesUseCase fishesUseCase;

  FishesViewModel({
    required this.fishesUseCase,
  });

  void setFishes(List<Fish> value) {
    fishes = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setSearching(bool value) {
    searching = value;
    notifyListeners();
  }

  Future<void> getFishes(String search) async {
    setSearching(search.isNotEmpty);
    setLoading(true);

    FishResponse fishResponse = await fishesUseCase.getFishes(search);

    setLoading(false);

    if (fishResponse.responseStatus != ResponseStatus.success) {
      Functions.showMessageResponseStatus(
        fishResponse.responseStatus,
        'Buscar',
        'os',
        'peixes',
      );
    }

    setFishes(fishResponse.fishes);
  }
}
