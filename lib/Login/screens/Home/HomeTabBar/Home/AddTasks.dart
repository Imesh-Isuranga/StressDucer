import 'package:flutter/material.dart';

class AddTasks {

  late DateTime pickedDate = DateTime.now();
  late TimeOfDay pickedTime = TimeOfDay.now();

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      this.pickedDate = pickedDate;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
      this.pickedTime = pickedTime;
    }
  }




  void modelBottomPanelSettings(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height:
              MediaQuery.of(context).size.height, // Take up full screen height
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Task Name : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.7, // Set the desired width
                    child: TextField(
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                      print("7777777777777777");
                      if(pickedDate != null){
                        print(pickedDate);
                      }
                    },
                    child: Text('Select Date'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                      if(pickedTime != null){
                      print(pickedTime);
                      }
                    },
                    child: Text('Select Time'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
