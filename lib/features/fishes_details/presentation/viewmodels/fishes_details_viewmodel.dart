import 'package:fishes/features/fishes/domain/entities/fishes_entity.dart';
import 'package:flutter/material.dart';

class FishesDetailsViewModel extends ChangeNotifier {
  Fish? fish;

  void setFish(Fish? value) {
    fish = value;
    notifyListeners();
  }
}
