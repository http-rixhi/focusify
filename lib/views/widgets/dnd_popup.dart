import 'package:do_not_disturb/do_not_disturb_plugin.dart';
import 'package:do_not_disturb/types.dart';
import 'package:flutter/material.dart';
import 'package:focusify/views/widgets/bottomBar.dart';

import 'Colors.dart';

class DndPopup extends StatefulWidget {
  const DndPopup({super.key});

  @override
  State<DndPopup> createState() => _DndPopupState();
}

class _DndPopupState extends State<DndPopup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        backgroundColor: darkLevel2,
        title: Text('DND'),
        content: Text("Do you want to enable DND?"),
        actions: [
          ElevatedButton(onPressed: () {
            // Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBarWidget()));
          }, child: Text("No")),
          ElevatedButton(onPressed: () async {
            final dndPlugin = DoNotDisturbPlugin();

            // Set DND mode (requires permission)
            if (await dndPlugin.isNotificationPolicyAccessGranted()) {
              // enable DND
              await dndPlugin.setInterruptionFilter(InterruptionFilter.priority);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBarWidget()));
            } else {
              // Guide user to grant permission
              await dndPlugin.openNotificationPolicyAccessSettings();
              // Inform user to grant permission and return to the app
            }
          }, child: Text("Yes"))
        ],
      ),
    );
  }

  void DndButton() async {

  }
}
