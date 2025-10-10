import 'package:clock_mate/core/theme/app_colors.dart';
import 'package:clock_mate/features/home/blocs/home/home_cupit.dart';
import 'package:clock_mate/features/home/data/models/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDataPage extends StatefulWidget {
  final DayData? existingData;
  const AddDataPage({super.key, this.existingData});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  late DateTime selectedDate;
  final TextEditingController timeDurationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.existingData?.date ?? DateTime.now();
    timeDurationController.text =
        widget.existingData?.timeSpent.toString() ?? '';
    descriptionController.text = widget.existingData?.description ?? '';
    print("existing data: ${widget.existingData}");
  }

  Future<void> submit(BuildContext context) async {
    await context.read<HomeCupit>().addData(
      DayData(
        id: widget.existingData?.id,
        date: selectedDate,
        description: descriptionController.text,
        timeSpent: int.parse(timeDurationController.text),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Data"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(AppColors.textPrimary),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                // time duration field
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: _timeDurationField(),
                ),

                /// description field
                _descriptionField(),
                Text(
                  'selected date: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                ),
                TextButton(
                  onPressed: () {
                    // show date picker
                    showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        setState(() {
                          // update selected date
                          selectedDate = pickedDate;
                        });
                      }
                    });
                  },
                  child: const Text("Change Date"),
                ),
                SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Color(AppColors.primary),
                    textColor: Color(AppColors.background),
                    onPressed: () async {
                      await submit(context);
                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeDurationField() {
    return TextFormField(
      controller: timeDurationController,
      decoration: const InputDecoration(
        labelText: 'Time Duration',
        hintText: 'Minutes spent',
        prefixIcon: Icon(Icons.access_time),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter time duration';
        }
        return null;
      },
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      controller: descriptionController,
      minLines: 6,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Enter description',
        labelText: 'Enter description',
        prefixIcon: Icon(Icons.description),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
    );
  }
}
