import 'package:clock_mate/features/home/blocs/home/files_cupit.dart';
import 'package:clock_mate/features/home/blocs/home/files_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clock_mate/core/theme/app_colors.dart';
import 'package:clock_mate/features/home/blocs/home/home_cupit.dart';
import 'package:clock_mate/features/home/blocs/home/home_state.dart';
import 'package:clock_mate/features/home/data/models/day.dart';
import 'package:clock_mate/features/home/pages/screens/add_data_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime _today = DateTime.now();
  double totalHours = 0;
  double totalMins = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataPage()),
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
            onPressed: () async {
              final cupit = context.read<FilesCupit>();
              await cupit.uploadFile();
              final state = cupit.state;
              if (state is FilesError) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
                return;
              }
              if (state is FilesSuccess) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("File created successfully")),
                  );
                }
                await cupit.shareFile(state.file);
                final shareState = cupit.state;
                if (shareState is FilesError) {
                  if (mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(shareState.message)));
                  }
                  return;
                }
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<HomeCupit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeError) {
                return Center(child: Text(state.message));
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // fetch data for the selected month
                    _scrollableHorizontalCalender((monthIndex) async {
                      await context.read<HomeCupit>().fetchData(
                        DateTime(_today.year, monthIndex + 1, _today.day),
                      );
                    }),
                    const SizedBox(height: 16),
                    if (state is HomeMonthData)
                      ...state.data.map((dayData) {
                        totalHours += dayData.timeSpent ~/ 60;
                        totalMins += dayData.timeSpent % 60;
                        final hours = dayData.timeSpent ~/ 60;
                        final mins = dayData.timeSpent % 60;
                        return Column(
                          children: [
                            _buildDataCard(
                              dayData,
                              hours.toDouble(),
                              mins.toDouble(),
                            ),
                          ],
                        );
                      }),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Month hours: ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${totalHours.toInt()} hrs ${totalMins.toInt()} mins",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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

  Widget _scrollableHorizontalCalender(Function(int) onTap) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_today.month, (index) {
          return InkWell(
            onTap: () {
              onTap(index);
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

  Widget _buildDataCard(DayData data, double hours, double mins) {
    return GestureDetector(
      onLongPress: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Delete Entry"),
              content: Text("Are you sure you want to delete this entry?"),
              actions: [
                CupertinoDialogAction(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("Delete"),
                  onPressed: () async {
                    // Handle delete action
                    await context.read<HomeCupit>().deleteData(data);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDataPage(
              existingData: DayData(
                date: data.date,
                timeSpent: data.timeSpent,
                description: data.description,
                id: data.id,
              ),
            ),
          ),
        );
      },
      child: Card(
        color: Color(AppColors.primary),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
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
                      data.date.day.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _dateFormatter(data.date.month - 1),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${hours.toInt()} hours, ${mins.toInt()} mins',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
