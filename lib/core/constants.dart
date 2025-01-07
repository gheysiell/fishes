import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String baseUrl = 'https://zylalabs.com/api/1428/fish+species+database+api/';
  static const Duration timeoutDurationRemoteHttp = Duration(seconds: 10);
  static const String timeoutMessageException = 'timeout exception in';
  static const String genericMessageException = 'generic exception in';
  static const String messageBadRequest = 'bad request in';
  static final String apiKey = dotenv.get('API_KEY');
}
