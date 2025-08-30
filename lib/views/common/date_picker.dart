import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  const DatePicker({super.key,required this.controller});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
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
        labelText: "Select Date",
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onTap: _pickDate,
    );
  }
}