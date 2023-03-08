import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/consts/string.dart';
import 'package:weather_app/models/current_weather_model.dart';

var link =
    "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=6adbf24cabd9bcde6b8737f043a393db&units=metric";

getCurrentWeather() async {
  var response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    var data = currentWeaherDataFromJson(response.body.toString());
    return data;
  }
}
