import 'package:flutter/material.dart';
import 'package:home_fix/models/service_form_model.dart';
import 'package:home_fix/models/service_model.dart';
import 'package:home_fix/models/user_profile_model.dart';
import 'package:home_fix/view_models/service_form_view_model.dart';
import 'package:home_fix/views/common/date_picker.dart';
import 'package:home_fix/views/common/time_picker.dart';
import 'package:home_fix/views/components/service_form_page/service_form_drop_down_menu.dart';
import 'package:home_fix/views/components/service_form_page/service_form_profile_viewer.dart';
import 'package:provider/provider.dart';

class ServiceFormPage extends StatefulWidget {
  final ServiceModel service;
  const ServiceFormPage({super.key, required this.service});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  // Controllers and pickers are managed within the State.
  final _descriptionController = TextEditingController();
  final _timePickerController = TextEditingController();
  final _datePickerController = TextEditingController();
  late final TimePicker _timePicker;
  late final DatePicker _datePicker;

  @override
  void initState() {
    _timePicker = TimePicker(controller: _timePickerController,);
    _datePicker = DatePicker(controller:_datePickerController,);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  bool formValid(ServiceModel?service,UserProfileModel?activeProfile){
    return _timePickerController.text!= "" && _datePickerController.text != "" && service!= null && activeProfile != null;
  }

  @override
  Widget build(BuildContext context) {
    final serviceDropDownController = TextEditingController(text: widget.service.name);
    return ChangeNotifierProvider(
      create: (_) => ServiceFormViewModel(),
      child: Scaffold(
        // Added a descriptive AppBar for better context.
        appBar: AppBar(
          title: Text('Book'),
          elevation: 1,
        ),
        // Use a Builder to get a context that has the provider.
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            // Replaced the Column with a ListView for better structure and spacing.
            child: ListView(
              children: [
                const SizedBox(height: 20),
                ServiceDropDownMenu(service: widget.service, controller: serviceDropDownController,),
                const SizedBox(height: 20),
                const ProfileViewer(),
                const SizedBox(height: 20),
                _datePicker,
                const SizedBox(height: 20),
                _timePicker,
                const SizedBox(height: 20),
                // The text field widget is unchanged as requested.
                ServiceFormTextField(
                  label: "Description of Issue",
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 32),
                // Replaced OutlinedButton with a more prominent ElevatedButton.
                ElevatedButton(
                  onPressed: () {
                    final vm = context.read<ServiceFormViewModel>();
                    final valid = formValid(vm.currentService, vm.activeProfile);
                    if(valid){
                        final form = ServiceFormModel(
                        date: _datePickerController.text,
                        time: _timePickerController.text,
                        service: vm.currentService!,
                        profile: vm.activeProfile!
                      );
                      vm.send(form);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Confirm Booking"),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ServiceFormViewModel>();
    return FutureBuilder(
      future: vm.userProfileLoadSuccess, 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null){
          return LinearProgressIndicator();
        }
        return ProfileDropDownMenu();
      }
    );
  }
}




class ProfileDropDownEntry extends StatelessWidget {
  final UserProfileModel userProfile;
  const ProfileDropDownEntry({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userProfile.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          userProfile.address,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          userProfile.phoneNumber,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}


class ServiceFormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  const ServiceFormTextField({super.key, required this.label, required this.controller, required this.minLines, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent,width: 5)
        )
      ),
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
