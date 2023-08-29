import 'package:flutter/material.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final List<int> invalidNumbers = []; // Example invalid numbers

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    for (int i = 1; i < currentDate.day; i++) {
      invalidNumbers.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    int daysInCurrentMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            "You have only ${daysInCurrentMonth - currentDate.day} days for this month",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.red),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: daysInCurrentMonth,
              itemBuilder: (context, index) {
                final number = index + 1;
                final isValidNumber = !invalidNumbers.contains(number);

                return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(number.toString()),
                        if (!isValidNumber)
                          const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
