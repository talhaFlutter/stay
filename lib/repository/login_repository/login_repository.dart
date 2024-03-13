import 'dart:ui';

import 'package:stay_x/data/network/network_api_services.dart';
import 'package:stay_x/res/app_url/app_url.dart';


class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = await _apiService.postApi(data, AppUrl.loginApi);
    return response;
  }
}
