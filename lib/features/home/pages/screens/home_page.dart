import 'package:flutter/material.dart';
import 'package:kasi_care/core/theme/app_colors.dart';
import 'package:kasi_care/features/home/pages/screens/add_data_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime _today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDataPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("ScheduleSync"),
        backgroundColor: Color(AppColors.background),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black),
            onPressed: () {
              // downloads data for the month
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _scrollableHorizontalCalender(),
                GestureDetector(
                  child: Card(
                    color: Color(AppColors.primary),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(AppColors.background),
                            ),
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _today.day.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _dateFormatter(_today.month - 1),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Meeting with Team",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "10:00 AM - 11:00 AM",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _dateFormatter(int index) {
    // return month abbreviation
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[index];
  }

  Widget _scrollableHorizontalCalender() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_today.month, (index) {
          return InkWell(
            onTap: () {
              // downloads data for the month
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(AppColors.background),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(AppColors.primary),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      _dateFormatter(index),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
