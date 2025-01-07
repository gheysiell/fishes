import 'package:fishes/core/enums.dart';
import 'package:fishes/features/fishes/data/datasources/remote/fishes_datasource_remote_http.dart';
import 'package:fishes/features/fishes/data/dtos/fishes_response_dto.dart';
import 'package:fishes/features/fishes/domain/entities/fishes_response_entity.dart';
import 'package:fishes/features/fishes/domain/repositories/fishes_repository.dart';
import 'package:fishes/utils/functions.dart';

class FishesRepositoryImpl implements FishesRepository {
  FishesDataSourceRemoteHttp fishesDataSourceRemoteHttp;

  FishesRepositoryImpl({
    required this.fishesDataSourceRemoteHttp,
  });

  @override
  Future<FishResponse> getFishes(String search) async {
    if (!await Functions.checkConn()) {
      return FishResponse(
        fishes: [],
        responseStatus: ResponseStatus.noConnection,
      );
    }

    FishResponseDto fishResponseDto = await fishesDataSourceRemoteHttp.getFishes(search);

    return fishResponseDto.toEntity();
  }
}
