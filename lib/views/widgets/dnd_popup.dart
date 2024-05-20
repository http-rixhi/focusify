import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:concentrate_plus/views/widgets/bottomBar.dart';

class DndPopup extends StatefulWidget {
  const DndPopup({super.key});

  @override
  State<DndPopup> createState() => _DndPopupState();
}

class _DndPopupState extends State<DndPopup> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AlertDialog(
        title: Text('DND Option'),
        content: Text('Would you like to turn on DND?'),
        actions: <Widget>[
          ElevatedButton(onPressed: () async{
            if (await FlutterDnd.isNotificationPolicyAccessGranted ?? true) {
              await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBarWidget()));
            } else {
              FlutterDnd.gotoPolicySettings();
            }
          }, child: Text('Yes')),
          ElevatedButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBarWidget()));
          }, child: Text('No'))
        ],
            ),
      );
  }
}
