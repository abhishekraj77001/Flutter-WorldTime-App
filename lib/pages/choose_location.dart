import 'package:flutter/material.dart';
import 'package:world_time/pages/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> wtList = [];
  bool isLocationNavigated = false;

  Widget appBarTitle = new Text(
    "Search Sample",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );


  void initCountryDataFromJsonFile() async {
    WorldTime worldTime = WorldTime();
    wtList = await worldTime.getDataFromJsonFile();
    setState(() {});
  }

  void updateTime(index) async {
    WorldTime instance = wtList[index];
    instance = await instance.initCurrentDateAndTime();
    // Navigator.pop(context, {
    //   'wt':instance
    // });

    Navigator.pushNamed(context, '/home',
        arguments: {'wt': instance, 'navValue': 'true'});
  }

  @override
  void initState() {
    print('init from location');
    super.initState();
    initCountryDataFromJsonFile();
    isLocationNavigated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Choose Location'),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),
                onPressed: () {
                //  showSearch(context: context, delegate: DataSearch(listWords));
                })
          ],
        ),
        body: ListView.builder(
          itemCount: wtList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(wtList[index].country ?? ''),
                subtitle: Text(
                    '${wtList[index].countryCode ?? ''} - ${wtList[index].timeZoneName ?? ''}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(wtList[index].flagUrl ?? ''),
                  radius: 60.0,
                ),
              ),

            );

          },

        ));
  }








}
