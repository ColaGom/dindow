import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const BASE_URL = "https://api.airvisual.com/v2";
const KEY = 'iMXgaDAARYHwNLyaE';

class API {
  static Future getNearCityData(double lat, double lng) async {
    var url = BASE_URL + "/nearest_city?key=$KEY&lat=$lat&lng=$lng";
    var response = await http.get(url);

    debugPrint("getNearCityData $url");
    debugPrint(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return CityDataModel.fromJson(json);
    }
  }
}

class Current {
  Weather weather;
  Pollution pollution;

  Current({this.weather, this.pollution});

  factory Current.fromJson(Map<String, dynamic> parsedJson) {
    return Current(
        weather: Weather.fromJson(parsedJson['weather']),
        pollution: Pollution.fromJson(parsedJson['pollution']));
  }
}

class CityDataModel {
  String city;
  String state;
  String county;
  Location location;
  Current current;

  CityDataModel(
      {this.city, this.state, this.county, this.location, this.current});

  factory CityDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return CityDataModel(
        city: parsedJson['data']['city'],
        state: parsedJson['data']['state'],
        county: parsedJson['data']['state'],
        location: Location.fromJson(parsedJson['data']['location']),
        current: Current.fromJson(parsedJson['data']['current']));
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return Location(
        type: parsedJson['type'], coordinates: parsedJson['coordinates']);
  }
}

class Weather {
  String ts;
  int hu;
  String ic;
  int pr;
  int tp;
  int wd;
  int ws;

  Weather({this.ts, this.hu, this.ic, this.pr, this.tp, this.wd, this.ws});

  factory Weather.fromJson(Map<String, dynamic> parsedJson) {
    return Weather(
        ts: parsedJson['ts'],
        hu: parsedJson['aqius'],
        ic: parsedJson['mainus'],
        pr: parsedJson['aqicn'],
        tp: parsedJson['tp'],
        wd: parsedJson['wd'],
        ws: parsedJson['ws']);
  }
}

class Pollution {
  String ts;
  int aqius;
  String mainus;
  int aqicn;
  String maincn;

  Pollution({this.ts, this.aqius, this.mainus, this.aqicn, this.maincn});

  factory Pollution.fromJson(Map<String, dynamic> parsedJson) {
    return Pollution(
        ts: parsedJson['ts'],
        aqius: parsedJson['aqius'],
        mainus: parsedJson['mainus'],
        aqicn: parsedJson['aqicn'],
        maincn: parsedJson['maincn']);
  }
}

class Forcast {
  String ts;
  int aqius;
  int aqicn;
  int tp;
  int tp_min;
  int pr;
  int hu;
  int ws;
  int wd;
  String ic;

  Forcast(
      {this.ts,
      this.aqius,
      this.aqicn,
      this.tp,
      this.tp_min,
      this.pr,
      this.hu,
      this.ws,
      this.wd,
      this.ic});

  factory Forcast.fromJson(Map<String, dynamic> parsedJson) {
    return Forcast(
        ts: parsedJson['ts'],
        aqius: parsedJson['aqius'],
        aqicn: parsedJson['aqicn'],
        tp: parsedJson['tp'],
        tp_min: parsedJson['tp_min'],
        pr: parsedJson['pr'],
        hu: parsedJson['hu'],
        ws: parsedJson['ws'],
        wd: parsedJson['wd'],
        ic: parsedJson['ic']);
  }
}
