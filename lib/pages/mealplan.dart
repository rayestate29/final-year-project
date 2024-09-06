import 'package:flutter/material.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  // Example user data
  double tdee = 2500; // This should be calculated from your BMR, BMI, TDEE page
  String goal = "lose weight"; // This should be taken from user input

  @override
  Widget build(BuildContext context) {
    double calorieIntake;
    if (goal == "lose weight") {
      calorieIntake = tdee - 500;
    } else if (goal == "gain weight") {
      calorieIntake = tdee + 500;
    } else {
      calorieIntake = tdee;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Personalized Meal Plan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Caloric Intake: ${calorieIntake.toStringAsFixed(0)} calories/day",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _generateMealPlan(calorieIntake),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateMealPlan(double calorieIntake) {
    // Example Ghanaian meals (replace with actual meal data and logic)
    List<Map<String, dynamic>> meals = [
      {"meal": "Breakfast", "name": "Koko and Kose", "calories": 300},
      {"meal": "Lunch", "name": "Jollof Rice", "calories": 600},
      {"meal": "Snack", "name": "Plantain Chips", "calories": 150},
      {"meal": "Dinner", "name": "Fufu and Light Soup", "calories": 700},
    ];

    return meals.map((meal) {
      return Card(
        child: ListTile(
          title: Text("${meal['meal']}: ${meal['name']}"),
          subtitle: Text("Calories: ${meal['calories']}"),
        ),
      );
    }).toList();
  }
}
