import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled1/user.dart';

import 'api_url.dart';

class StateServices {
  Future<UserModel> getStates() async {
    final response = await http.get(Uri.parse(AppUrl.WorldStateUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }


  Future<List<dynamic>> getCountries() async {
    var data ;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
