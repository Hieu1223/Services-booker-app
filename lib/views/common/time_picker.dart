import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final TextEditingController controller;
  const TimePicker({super.key,required this.controller});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        widget.controller.text = "$hour:$minute";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent,width: 5)
        ),
        labelText: "Select Time",
        prefixIcon: Icon(Icons.access_time),
      ),
      onTap: _pickTime,
    );
  }
}
