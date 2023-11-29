import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:focusify/views/widgets/bottomBar.dart';

class DndPopup extends StatefulWidget {
  const DndPopup({super.key});

  @override
  State<DndPopup> createState() => _DndPopupState();
}

class _DndPopupState extends State<DndPopup> with WidgetsBindingObserver {


  // String _filterName = '';
  // bool? _isNotificationPolicyAccessGranted = false;

  // @override
  // void initState() {
  //   WidgetsBinding.instance!.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   print(state.toString());
  //   if (state == AppLifecycleState.resumed) {
  //     updateUI();
  //   }
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   updateUI();
  // }
  //
  // void updateUI() async {
  //   int? filter = await FlutterDnd.getCurrentInterruptionFilter();
  //   if (filter != null) {
  //     String filterName = FlutterDnd.getFilterName(filter);
  //     bool? isNotificationPolicyAccessGranted =
  //     await FlutterDnd.isNotificationPolicyAccessGranted;
  //
  //     setState(() {
  //       _isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
  //       _filterName = filterName;
  //     });
  //   }
  // }
  //
  // void setInterruptionFilter(int filter) async {
  //   final bool? isNotificationPolicyAccessGranted =
  //   await FlutterDnd.isNotificationPolicyAccessGranted;
  //   if (isNotificationPolicyAccessGranted != null &&
  //       isNotificationPolicyAccessGranted) {
  //     await FlutterDnd.setInterruptionFilter(filter);
  //     updateUI();
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return

    //   Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //       Text('Current Filter: $_filterName'),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Text(
    //           'isNotificationPolicyAccessGranted: ${_isNotificationPolicyAccessGranted! ? 'YES' : 'NO'}'),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           FlutterDnd.gotoPolicySettings();
    //         },
    //         child: Text('GOTO POLICY SETTINGS'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () async {
    //           setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
    //         },
    //         child: Text('TURN ON DND'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
    //         },
    //         child: Text('TURN OFF DND'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALARMS);
    //         },
    //         child: Text('TURN ON DND - ALLOW ALARM'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY);
    //         },
    //         child: Text('TURN ON DND - ALLOW PRIORITY'),
    //       )
    //     ],
    //   ),
    // );


      Scaffold(
        body: AlertDialog(
        title: Text('DND Option'),
        content: Text('Would you like to turn on DND?'),
        actions: <Widget>[
          ElevatedButton(onPressed: () async{
            // bool? isDndEnabled = await FlutterDnd.isNotificationPolicyAccessGranted;
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
