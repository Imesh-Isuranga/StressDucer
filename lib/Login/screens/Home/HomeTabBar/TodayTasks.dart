import 'package:flutter/material.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({super.key});

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  bool _selected = false;
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Today Tasks",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            enabled: _enabled,
            // This sets text color and icon color to red when list tile is disabled and
            // green when list tile is selected, otherwise sets it to black.
            iconColor:
                MaterialStateColor.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.red;
              }
              return Colors.black;
            }),
            // This sets text color and icon color to red when list tile is disabled and
            // green when list tile is selected, otherwise sets it to black.
            textColor:
                MaterialStateColor.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.red;
              }
              return Colors.black;
            }),
            leading: const Icon(Icons.person),
            title: const Text('Subject'),
            subtitle: Text('Enabled: $_enabled'),
            trailing: Switch(
              onChanged: (bool? value) {
                setState(() {
                  _enabled = value!;
                });
              },
              value: _enabled,
            ),
          ),
        ],
      ),
    );
  }
}
