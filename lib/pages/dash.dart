import 'package:finalc/graphs/app_resources.dart';
import 'package:finalc/graphs/indicator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          .collection('meals')
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
        final int protein = data['protein'];
        final int fats = data['fats'];
        final int carbs = data['carbs'];
        final int totalCalories = (protein * 4) + (fats * 9) + (carbs * 4);

        proteinCalories += (protein * 4);
        fatsCalories += (fats * 9);
        carbsCalories += (carbs * 4);

        final String mealType = data['type'];
        if (mealType == 'Breakfast') {
          breakfast += totalCalories;
        } else if (mealType == 'Lunch') {
          lunch += totalCalories;
        } else if (mealType == 'Dinner') {
          dinner += totalCalories;
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
      // Handle errors appropriately
      setState(() {
        isLoading = false;
      });
      print("Error retrieving data: $e");
    }
  }

  void updateWeeklyCalories() async {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('meals')
          .where('trackedTime', isGreaterThanOrEqualTo: startOfWeek)
          .where('trackedTime', isLessThan: endOfWeek)
          .get();

      Map<String, int> tempWeeklyCalories = {
        'Mon': 0,
        'Tue': 0,
        'Wed': 0,
        'Thu': 0,
        'Fri': 0,
        'Sat': 0,
        'Sun': 0,
      };

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final int protein = data['protein'];
        final int fats = data['fats'];
        final int carbs = data['carbs'];
        final int totalCalories = (protein * 4) + (fats * 9) + (carbs * 4);

        final DateTime trackedTime = data['trackedTime'].toDate();
        final int dayOfWeek = trackedTime.weekday;

        switch (dayOfWeek) {
          case 1:
            tempWeeklyCalories['Mon'] = tempWeeklyCalories['Mon']! + totalCalories;
            break;
          case 2:
            tempWeeklyCalories['Tue'] = tempWeeklyCalories['Tue']! + totalCalories;
            break;
          case 3:
            tempWeeklyCalories['Wed'] = tempWeeklyCalories['Wed']! + totalCalories;
            break;
          case 4:
            tempWeeklyCalories['Thu'] = tempWeeklyCalories['Thu']! + totalCalories;
            break;
          case 5:
            tempWeeklyCalories['Fri'] = tempWeeklyCalories['Fri']! + totalCalories;
            break;
          case 6:
            tempWeeklyCalories['Sat'] = tempWeeklyCalories['Sat']! + totalCalories;
            break;
          case 7:
            tempWeeklyCalories['Sun'] = tempWeeklyCalories['Sun']! + totalCalories;
            break;
        }
      }

      setState(() {
        weeklyCalories = tempWeeklyCalories;
      });
    } catch (e) {
      // Handle errors appropriately
      print("Error retrieving data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.pageBackground,
        title: const Text('WELCOME TO DASHBOARD', style: TextStyle(color: Colors.white)),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : buildDashboardContent(),
    );
  }

  Widget buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Daily Activity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCalorieContainer('Breakfast', breakfastCalories, AppColors.contentColorPurple.withOpacity(0.7)),
                buildCalorieContainer('Lunch', lunchCalories, Colors.lightBlueAccent),
                buildCalorieContainer('Dinner', dinnerCalories, AppColors.contentColorYellow),
              ],
            ),
            const SizedBox(height: 20),
            PieChartSample2(
              proteinCalories: totalProteinCalories ?? 0,
              fatsCalories: totalFatsCalories ?? 0,
              carbsCalories: totalCarbsCalories ?? 0,
            ),
            const SizedBox(height: 40), // Increased height here
            const Text(
              'Weekly Calorie Input',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70), // Increased height here
            BarChartSample(weeklyCalories: weeklyCalories),
          ],
        ),
      ),
    );
  }

  Widget buildCalorieContainer(String meal, int? calories, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(meal, style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 8),
            Text(
              '${calories ?? 0} kcal',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  final int proteinCalories;
  final int fatsCalories;
  final int carbsCalories;

  const PieChartSample2({
    super.key,
    required this.proteinCalories,
    required this.fatsCalories,
    required this.carbsCalories,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: AspectRatio(
            aspectRatio: 4.3,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Indicator(
              color: AppColors.contentColorBlue,
              text: 'Proteins',
              isSquare: true,
              textColor: Colors.white,
            ),
            SizedBox(height: 4),
            Indicator(
              color: AppColors.contentColorYellow,
              text: 'Fats',
              isSquare: true,
              textColor: Colors.white,
            ),
            SizedBox(height: 4),
            Indicator(
              color: AppColors.contentColorPink,
              text: 'Carbs',
              isSquare: true,
              textColor: Colors.white,
            ),
            SizedBox(height: 18),
          ],
        ),
        const SizedBox(width: 28),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: widget.proteinCalories.toDouble(),
            title: '${widget.proteinCalories} kcal',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: widget.fatsCalories.toDouble(),
            title: '${widget.fatsCalories} kcal',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPink,
            value: widget.carbsCalories.toDouble(),
            title: '${widget.carbsCalories} kcal',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class BarChartSample extends StatefulWidget {
  final Map<String, int> weeklyCalories;

  const BarChartSample({super.key, required this.weeklyCalories});

  @override
  State<BarChartSample> createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final List<Color> colors = List.generate(7, (_) => Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1));

    return Container(
      height: 400, // Increased height
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchCallback: (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final weekDay = widget.weeklyCalories.keys.elementAt(group.x.toInt());
                return BarTooltipItem(
                  '$weekDay\n${rod.toY.toInt()} kcal',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 0:
                      text = const Text('Mon', style: style);
                      break;
                    case 1:
                      text = const Text('Tue', style: style);
                      break;
                    case 2:
                      text = const Text('Wed', style: style);
                      break;
                    case 3:
                      text = const Text('Thu', style: style);
                      break;
                    case 4:
                      text = const Text('Fri', style: style);
                      break;
                    case 5:
                      text = const Text('Sat', style: style);
                      break;
                    case 6:
                      text = const Text('Sun', style: style);
                      break;
                    default:
                      text = const Text('', style: style);
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4,
                    child: text,
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Removed left Y-axis labels
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Removed right Y-axis labels
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Removed top X-axis labels
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: widget.weeklyCalories.entries.map((entry) {
            final index = widget.weeklyCalories.keys.toList().indexOf(entry.key);
            final dayCalories = entry.value.toDouble();
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: dayCalories,
                  color: colors[index],
                  width: 20,
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }).toList(),
        ),
      ),
    );
  }
}
