import 'package:flutter/material.dart';
import 'package:world_time/pages/world_time.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late WorldTime wt=WorldTime();
  bool isLocationNavigated=false;

  @override
  Widget build(BuildContext context) {

    dynamic data= ModalRoute.of(context)!.settings.arguments;
    if(data!=null && wt.country==null)
      {
        try
        {
          wt= data['wt'];
          var navValue=data['navValue'];
          isLocationNavigated=navValue=='true'?true:false;
        }
        catch(e)
        {
            print('incatch.....');
        }

      }
    String backgroundImage=wt.isDaytime?'morning.jpg':'night.jpg';
    Color? fontColor=wt.isDaytime?Colors.black:Colors.grey[200];

    Color? bgColor = wt.isDaytime?Colors.blue:Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$backgroundImage'),
            fit: BoxFit.cover
          )

        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Center(
            child: Column(
              children: [
                TextButton.icon(
                onPressed: () {

                  navigateToLocation();
                },
                icon: Icon(Icons.edit_location),
                label: Text(
                    'Edit Location',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),

                )
                ),
                SizedBox(height: 40,),
                Text(
                    wt.country??'Unknown Location',
                  style: TextStyle(
                    color: fontColor,
                    fontSize: 24,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  wt.time??'Unknown Time',
                  style: TextStyle(
                    color: fontColor,
                      fontSize: 32,
                      letterSpacing: 2.0
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  wt.date??'Unknown Date',
                  style: TextStyle(
                    color: fontColor,
                      fontSize: 32,
                      letterSpacing: 2.0
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToLocation() async
  {
    if(!isLocationNavigated)
      {
        dynamic result = await Navigator.popAndPushNamed((context), '/location');
        if(result!=null)
        {
          setState(() {
            wt=result['wt'];
          });
        }
      }
    else
      {
        Navigator.pop(context);
      }

  }
}