import 'package:flutter/material.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({super.key});

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {

  List<String> todaySubjectsList = ['A','B','C','d','t','A','B','C','d','t'];
  List<bool> _enable=[];

  @override
  void initState() {
    for (int i=0; i<todaySubjectsList.length; i++){
    _enable.add(false);
  }
    super.initState();
  }

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
          Expanded(
            child: ListView.builder(
              itemCount: todaySubjectsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  enabled: _enable[index],
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
                  subtitle: Text('Enabled: ${_enable[index]}'),
                  trailing: Switch(
                    onChanged: (bool? value) {
                      setState(() {
                        _enable[index] = value!;
                      });
                    },
                    value: _enable[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
