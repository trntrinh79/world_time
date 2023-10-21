import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name
  late String time; // time in that location
  late String flag; // url to asset the flag icon
  late String url; //location url for api endpoint
  late bool isDayTime = true;
  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });
  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.https("worldtimeapi.org", "/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      //get properties from data

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print(dateTime);
      // print(offset);

      //create date time object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      //set time prop
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = "could not get time data";
    }
  }
}
