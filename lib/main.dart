import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(DindowApp());

const String TITLE = "Dindow";

class DindowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: TITLE,
      home: DustScreen(),
    );
  }
}

class DustScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DustScreenState();
}

class _DustScreenState extends State<DustScreen> {
  double _dustFactor = 0.0;
  String _dustDesc = "none";
  String _positionInfo = "waiting...";
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TITLE),
        elevation: 4.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: ThemeData.light().primaryColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.child_care, size: 100.0, color: _iconColor),
                  Text(
                    _dustFactor.toString(),
                    textScaleFactor: 3,
                  ),
                  Text(
                    _dustDesc,
                    textScaleFactor: 2,
                  ),
                  Text(
                    _positionInfo,
                    textScaleFactor: 1.2,
                  )
                ],
              ),
            ) ,
          )
        ],
      ),
    );
  }

  void requestPermission() {
    var requestFuture =
        PermissionHandler().requestPermissions([PermissionGroup.location]);

    requestFuture.then((result) {
      if (result[PermissionGroup.location] != PermissionStatus.granted) {
        setState(() {
          _dustDesc = "Location permission denied... :(";
        });
      } else {
        requestGps();
      }
    });
  }

  void requestGps() {
    var locator = Geolocator();
    var options =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    locator.getCurrentPosition().then((position) {
      updatePosition(position);
    });

    locator.getPositionStream(options).listen((position) {
      updatePosition(position);
    });
  }

  void updatePosition(Position position){
    setState(() {
      _positionInfo = (position == null) ? "null" : "lat : ${position.latitude}";
    });
  }
}
