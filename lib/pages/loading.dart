import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/pages/world_time.dart';

class Loading extends StatefulWidget {

  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late WorldTime wt=WorldTime();

  fetchDetails() async
  {
    wt=await wt.initCurrentDateAndTime();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'wt':wt
    });

  }
@override
  void initState() {
    super.initState();
    fetchDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      )
    );
  }

}
