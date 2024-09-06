import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int? breakfastCalories;
  int? lunchCalories;
  int? dinnerCalories;

  int? totalProteinCalories;
  int? totalFatsCalories;
  int? totalCarbsCalories;

  bool isLoading = true;
  Map<String, int> weeklyCalories = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'Sun': 0,
  };

  @override
  void initState() {
    super.initState();
    updateCalories();
    updateWeeklyCalories();
  }

  void updateCalories() async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime tomorrow = today.add(const Duration(days: 1));

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('trackedFoods')
          .where('trackedTime', isGreaterThanOrEqualTo: today)
          .where('trackedTime', isLessThan: tomorrow)
          .get();

      int breakfast = 0;
      int lunch = 0;
      int dinner = 0;

      int proteinCalories = 0;
      int fatsCalories = 0;
      int carbsCalories = 0;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final double protein = data['protein'];
        final double fats = data['fats'];
        final double carbs = data['carbs'];
        final double totalCalories = (protein * 4) + (fats * 9) + (carbs * 4);

        proteinCalories += (protein * 4).toInt();
        fatsCalories += (fats * 9).toInt();
        carbsCalories += (carbs * 4).toInt();

        final String mealType = data['mealType'];
        if (mealType == 'Breakfast') {
          breakfast += totalCalories.toInt();
        } else if (mealType == 'Lunch') {
          lunch += totalCalories.toInt();
        } else if (mealType == 'Dinner') {
          dinner += totalCalories.toInt();
        }
      }

      setState(() {
        breakfastCalories = breakfast;
        lunchCalories = lunch;
        dinnerCalories = dinner;
        totalProteinCalories = proteinCalories;
        totalFatsCalories = fatsCalories;
        totalCarbsCalories = carbsCalories;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error updating calories: $e');
    }
  }

  void updateWeeklyCalories() async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    for (int i = 0; i < 7; i++) {
      final DateTime start = today.subtract(Duration(days: i));
      final DateTime end = start.add(const Duration(days: 1));

      final querySnapshot = await FirebaseFirestore.instance
          .collection('trackedFoods')
          .where('trackedTime', isGreaterThanOrEqualTo: start)
          .where('trackedTime', isLessThan: end)
          .get();

      int dailyCalories = 0;
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final double protein = data['protein'];
        final double fats = data['fats'];
        final double carbs = data['carbs'];
        dailyCalories += ((protein * 4) + (fats * 9) + (carbs * 4)).toInt();
      }

      final String weekday = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][start.weekday % 7];
      weeklyCalories[weekday] = dailyCalories;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Page'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Daily Calories', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCalorieContainer('Breakfast', breakfastCalories),
                        buildCalorieContainer('Lunch', lunchCalories),
                        buildCalorieContainer('Dinner', dinnerCalories),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text('Daily Macronutrients Breakdown', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: totalProteinCalories?.toDouble(),
                            title: '${totalProteinCalories ?? 0} kcal\nProtein',
                            radius: 100,
                            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          PieChartSectionData(
                            color: Colors.yellow,
                            value: totalFatsCalories?.toDouble(),
                            title: '${totalFatsCalories ?? 0} kcal\nFats',
                            radius: 100,
                            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: totalCarbsCalories?.toDouble(),
                            title: '${totalCarbsCalories ?? 0} kcal\nCarbs',
                            radius: 100,
                            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Weekly Calorie Info', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    PieChart(
                      PieChartData(
                        sections: weeklyCalories.entries.map((entry) {
                          return PieChartSectionData(
                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            value: entry.value.toDouble(),
                            title: '${entry.key}\n${entry.value} kcal',
                            radius: 100,
                            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildCalorieContainer(String mealType, int? calories) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(mealType, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          Text('${calories ?? 0} kcal', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
