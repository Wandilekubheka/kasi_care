import 'package:flutter/material.dart';
import 'package:kasi_care/core/theme/app_colors.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
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
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Color(AppColors.primary),
                    textColor: Color(AppColors.background),
                    onPressed: () {},
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
