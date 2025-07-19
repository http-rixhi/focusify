import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../../widgets/Colors.dart';

class Reminder {
  final String id;
  final String title;
  final String description;
  final TimeOfDay time;
  final List<int> days; // 1-7 for Monday-Sunday
  final bool isActive;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.days,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'hour': time.hour,
        'minute': time.minute,
        'days': days,
        'isActive': isActive,
      };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        time: TimeOfDay(hour: json['hour'], minute: json['minute']),
        days: List<int>.from(json['days']),
        isActive: json['isActive'],
      );
}

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<Reminder> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _requestNotificationPermission();
    _initNotifications();
    _loadReminders();
  }

  Future<void> _requestNotificationPermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) { // Android 13+
      final status = await Permission.notification.request();
      if (status.isDenied) {
        // Handle the case where user denied the permission
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notification permission is required for reminders')),
          );
        }
      }
    }
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );
  }

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getStringList('reminders') ?? [];
    
    setState(() {
      _reminders = remindersJson
          .map((json) => Reminder.fromJson(
              Map<String, dynamic>.from(json as Map<String, dynamic>)))
          .toList();
      _isLoading = false;
    });
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson =
        _reminders.map((reminder) => reminder.toJson()).toList();
    await prefs.setStringList(
        'reminders', remindersJson.map((e) => e.toString()).toList());
  }

  Future<void> _scheduleReminder(Reminder reminder) async {
    if (!reminder.isActive) return;

    final now = DateTime.now();
    final time = DateTime(
      now.year,
      now.month,
      now.day,
      reminder.time.hour,
      reminder.time.minute,
    );

    final androidDetails = const AndroidNotificationDetails(
      'study_reminder',
      'Study Reminders',
      channelDescription: 'Notifications for study reminders',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    if (reminder.days.isEmpty) {
      // One-time reminder
      if (time.isAfter(now)) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          int.parse(reminder.id),
          reminder.title,
          reminder.description,
          tz.TZDateTime.from(time, tz.local),
          platformDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      }
    } else {
      // Repeating reminder
      for (final day in reminder.days) {
        final scheduledDate = _nextInstanceOfDay(day, reminder.time);
        await flutterLocalNotificationsPlugin.zonedSchedule(
          int.parse('${reminder.id}$day'),
          reminder.title,
          reminder.description,
          scheduledDate,
          platformDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  }

  tz.TZDateTime _nextInstanceOfDay(int day, TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // Find the next occurrence of the specified day (1 = Monday, 7 = Sunday)
    int daysToAdd = (day - scheduledDate.weekday + 7) % 7;
    if (daysToAdd == 0) {
      // If it's the same day, check if time has passed
      if (scheduledDate.isBefore(now)) {
        daysToAdd = 7; // Move to same day next week
      }
    }
    
    scheduledDate = scheduledDate.add(Duration(days: daysToAdd));
    return scheduledDate;
  }

  Future<void> _addReminder() async {
    final result = await showDialog<Reminder>(
      context: context,
      builder: (context) => const AddReminderDialog(),
    );

    if (result != null) {
      setState(() {
        _reminders.add(result);
      });
      await _saveReminders();
      await _scheduleReminder(result);
    }
  }

  Future<void> _toggleReminder(Reminder reminder, bool value) async {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      final updatedReminder = Reminder(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        time: reminder.time,
        days: List.from(reminder.days),
        isActive: value,
      );

      setState(() {
        _reminders[index] = updatedReminder;
      });

      await _saveReminders();
      
      if (value) {
        await _scheduleReminder(updatedReminder);
      } else {
        // Cancel all notifications for this reminder
        for (final day in reminder.days) {
          await flutterLocalNotificationsPlugin.cancel(int.parse('${reminder.id}$day'));
        }
      }
    }
  }

  Future<void> _deleteReminder(String id) async {
    setState(() {
      _reminders.removeWhere((reminder) => reminder.id == id);
    });
    await _saveReminders();
    // Cancel all notifications for this reminder
    for (var day = 1; day <= 7; day++) {
      await flutterLocalNotificationsPlugin.cancel(int.parse('${id}$day'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkLevel1,
        title: const Text('Study Reminder'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reminders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.notifications_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('No reminders yet!', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _addReminder,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Reminder'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = _reminders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(reminder.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reminder.description),
                            const SizedBox(height: 4),
                            Text(
                              '${_formatTime(reminder.time)} • ${_formatDays(reminder.days)}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: reminder.isActive,
                              onChanged: (value) => _toggleReminder(reminder, value),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteReminder(reminder.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  String _formatDays(List<int> days) {
    if (days.isEmpty) return 'Once';
    if (days.length == 7) return 'Every day';
    
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days.map((day) => dayNames[day - 1]).join(', ');
  }
}

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({super.key});

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<int> _selectedDays = [];
  bool _isRepeating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _toggleDay(int day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
        _selectedDays.sort();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Reminder'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Time'),
                trailing: TextButton(
                  onPressed: _selectTime,
                  child: Text(
                    _selectedTime.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text('Repeating'),
                value: _isRepeating,
                onChanged: (value) {
                  setState(() {
                    _isRepeating = value;
                    if (!_isRepeating) {
                      _selectedDays.clear();
                    }
                  });
                },
              ),
              if (_isRepeating) ..._buildDaySelectors(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final reminder = Reminder(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: _titleController.text,
                description: _descriptionController.text,
                time: _selectedTime,
                days: _isRepeating ? List.from(_selectedDays) : [],
              );
              Navigator.pop(context, reminder);
            }
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }

  List<Widget> _buildDaySelectors() {
    final dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return [
      const SizedBox(height: 8),
      const Text('Repeat on:', style: TextStyle(fontSize: 14, color: Colors.grey)),
      const SizedBox(height: 8),
      SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final day = index + 1; // 1-7 for Monday-Sunday
            final isSelected = _selectedDays.contains(day);
            return GestureDetector(
              onTap: () => _toggleDay(day),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300]!,
                  ),
                ),
                child: Center(
                  child: Text(
                    dayNames[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ];
  }
}
