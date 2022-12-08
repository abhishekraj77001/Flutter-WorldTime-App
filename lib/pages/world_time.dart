import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/services.dart';

class WorldTime
{
    String? country;
    String? time;
    String? date;
    String? countryCode;
    String? timeZoneName;
    String? gtmOffset;
    String? flagUrl;
    bool isDaytime=false;

    WorldTime({this.country,this.countryCode,this.timeZoneName,this.gtmOffset,this.flagUrl});

    factory WorldTime.fromJson(dynamic json) {
       return  WorldTime(
           country: json['Country'],
           countryCode: json['Country_Code'],
           timeZoneName: json['Time_Zone_Name'],
           gtmOffset: json['GMT_Offset'],
           flagUrl: 'https://countryflagsapi.com/png/'+json['Country_Code']
       );
    }


    Future<List<WorldTime>> getDataFromJsonFile() async
    {
        var jsonResult = await rootBundle.loadString('assets/Country_TimeZone.json');
        List dynamicList=jsonDecode(jsonResult);
        List<WorldTime> wtlist= dynamicList.map(
                (e) {
                    return  WorldTime.fromJson(e);
                }
        ).toList();

        return wtlist;

    }

    Future<WorldTime> initCurrentDateAndTime() async
    {
        WorldTime  default_currentTime= WorldTime(
            country: 'India',
            countryCode: 'IN',
            timeZoneName: 'Asia/Kolkata',
            flagUrl: 'https://countryflagsapi.com/png/in'
        );

        try{
            tz.initializeTimeZones();
            var timeimeZone = tz.getLocation(timeZoneName.toString());
            var now = tz.TZDateTime.now(timeimeZone);
            final format = DateFormat.jm();
           // String fr= format.format(now);
            time=format.format(now);
            isDaytime=now.hour>6 && now.hour <20?true:false;
            date='${now.day}-${now.month}-${now.year}';
        }
        catch(e)
        {
            var kolkataTimeZone = tz.getLocation(default_currentTime.timeZoneName.toString());
            var now = tz.TZDateTime.now(kolkataTimeZone);
            final format = DateFormat.jm();
            //String fr= format.format(now);
            default_currentTime.time=format.format(now);
            default_currentTime.date='${now.day}-${now.month}-${now.year}';
            default_currentTime.isDaytime=(now.hour>6 && now.hour <20)?true:false;
            return default_currentTime;
        }
        return this;
    }

    bool isDay(String time)
    {
        bool temp=false;



        return temp;

    }



}
