import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fishes/core/constants.dart';
import 'package:fishes/core/enums.dart';
import 'package:fishes/features/fishes/data/dtos/fishes_dto.dart';
import 'package:http/http.dart' as http;
import 'package:fishes/features/fishes/data/dtos/fishes_response_dto.dart';

abstract class FishesDataSourceRemoteHttp {
  Future<FishResponseDto> getFishes(String search);
}

class FishesDataSourceRemoteHttpImpl implements FishesDataSourceRemoteHttp {
  @override
  Future<FishResponseDto> getFishes(String search) async {
    FishResponseDto fishResponseDto = FishResponseDto(
      fishesDto: [],
      responseStatus: ResponseStatus.success,
    );

    final String urlFormatted = search.isNotEmpty ? '1177/fish+data+by+name?name=$search' : '1176/all+species';
    final Uri uri = Uri.parse(Constants.baseUrl + urlFormatted);
    final Map<String, String> header = {
      'Authorization': 'Bearer ${Constants.apiKey}',
    };

    try {
      final response = await http.get(uri, headers: header).timeout(Constants.timeoutDurationRemoteHttp);

      if (response.statusCode != 200) {
        log(Constants.messageBadRequest, error: 'response: ${response.body} | status: ${response.statusCode}');
        throw Exception();
      }

      List fishesResponse = json.decode(response.body);

      fishResponseDto.fishesDto = fishesResponse.map((fish) => FishDto.fromMap(fish)).toList();
    } on TimeoutException {
      log('${Constants.timeoutMessageException} FishesDataSourceRemoteHttpImpl.getFishes');
      fishResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericMessageException} FishesDataSourceRemoteHttpImpl.getFishes', error: e);
      fishResponseDto.responseStatus = ResponseStatus.error;
    }

    return fishResponseDto;
  }
}
