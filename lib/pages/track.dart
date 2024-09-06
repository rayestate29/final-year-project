import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealTrackerApp extends StatelessWidget {
  const MealTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TrackingPage(),
    );
  }
}

class Meal {
  Meal({
    required this.name,
    required this.type,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.trackedTime,
  });

  final double carbs;
  final double fats;
  final String name;
  final double protein;
  final DateTime trackedTime;
  final String type;
}

class NutritionMeal {
  NutritionMeal({
    required this.mealName,
    required this.servingSizes,
    required this.imageUrl,
  });

  final String imageUrl;
  final String mealName;
  final List<dynamic> servingSizes;
}

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final _carbsController = TextEditingController();
  final _fatsController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  final _mealNameController = TextEditingController();
  String _mealType = 'Breakfast';
  final _proteinController = TextEditingController();
  final _searchMealController = TextEditingController();
  NutritionMeal? _searchedMeal;

  Future<void> _trackMeal() async {
    final mealName = _mealNameController.text.trim();
    final proteinGrams = double.tryParse(_proteinController.text) ?? 0;
    final fatsGrams = double.tryParse(_fatsController.text) ?? 0;
    final carbsGrams = double.tryParse(_carbsController.text) ?? 0;

    if (mealName.isEmpty || (proteinGrams == 0 && fatsGrams == 0 && carbsGrams == 0)) {
      _showErrorDialog('Please fill in at least the Meal Name, Meal Type, and one of the Macronutrient fields.');
      return;
    }

    final proteinCalories = proteinGrams * 4;
    final fatsCalories = fatsGrams * 9;
    final carbsCalories = carbsGrams * 4;
    final totalCalories = proteinCalories + fatsCalories + carbsCalories;


    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('meals').add({
        'name': mealName,
        'type': _mealType,
        'protein': proteinGrams,
        'fats': fatsGrams,
        'carbs': carbsGrams,
        'trackedTime': Timestamp.fromDate(DateTime.now()),
      });

      _mealNameController.clear();
      _proteinController.clear();
      _fatsController.clear();
      _carbsController.clear();

      _showConfirmationDialog(
        'Meal Tracked',
        'Meal Name: $mealName\nMeal Type: $_mealType\nProtein: $proteinCalories kcal\nFats: $fatsCalories kcal\nCarbs: $carbsCalories kcal\nTotal: $totalCalories kcal',
      );
    } catch (error) {
      _showErrorDialog('Failed to track meal: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchMeal() async {
    final mealName = _searchMealController.text.trim();

    if (mealName.isEmpty) {
      _showErrorDialog('Please enter a meal name to search.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final querySnapshot = await _firestore
          .collection('nutrition')
          .where('meal_name', isEqualTo: mealName)
          .get();

      if (querySnapshot.docs.isEmpty) {
        _showAlertDialog('No Results', 'No meals found with the entered name.');
        return;
      }

      final data = querySnapshot.docs.first.data();
      setState(() {
        _searchedMeal = NutritionMeal(
          mealName: data['meal_name'],
          servingSizes: data['serving_sizes'],
          imageUrl: data['image_url'],
        );
      });
    } catch (error) {
      _showErrorDialog('Failed to search meal: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showConfirmationDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          backgroundColor: Colors.lightBlueAccent,
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.red)),
          content: Text(errorMessage, style: const TextStyle(color: Colors.red)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALORIES PAGE', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Find Calories in Meal', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchMealController,
                              decoration: const InputDecoration(
                                labelText: 'Search',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _searchMeal,
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _searchedMeal != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _searchedMeal!.mealName,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text('Serving Sizes:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                  for (var size in _searchedMeal!.servingSizes)
                                    Text('- $size', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 50),
                                    child: _searchedMeal!.imageUrl.isNotEmpty
                                        ? Image.network(
                                            _searchedMeal!.imageUrl,
                                            height: 300,
                                            fit: BoxFit.cover,
                                          )
                                        : const Text('No image available'),
                                  ),
                                ],
                              ),
                            )
                          : const Text('No meal selected', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TRACK MEAL', style: TextStyle(fontSize: 24)),
                  TextField(
                    controller: _mealNameController,
                    decoration: const InputDecoration(labelText: 'Meal Name'),
                  ),
                  const SizedBox(height: 30),
                  DropdownButton<String>(
                    value: _mealType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _mealType = newValue!;
                      });
                    },
                    items: <String>['Breakfast', 'Lunch', 'Dinner']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _proteinController,
                    decoration: const InputDecoration(labelText: 'Protein (g)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _fatsController,
                    decoration: const InputDecoration(labelText: 'Fats (g)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _carbsController,
                    decoration: const InputDecoration(labelText: 'Carbohydrates (g)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _trackMeal,
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      elevation: 100,
                      side: const BorderSide(width: 2.0),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'TRACK MEAL',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Meal Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Meal Info'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MealInfoPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MealInfoPage extends StatelessWidget {
  const MealInfoPage({super.key});

  Future<void> _deleteMeal(String mealId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('meals').doc(mealId).delete();
    } catch (error) {
      print('Failed to delete meal: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Info'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('meals').orderBy('trackedTime').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final meals = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Meal(
              name: data['name'],
              type: data['type'],
              protein: data['protein'],
              fats: data['fats'],
              carbs: data['carbs'],
              trackedTime: data['trackedTime'].toDate(),
            );
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('No.')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Protein (g)')),
                  DataColumn(label: Text('Fats (g)')),
                  DataColumn(label: Text('Carbs (g)')),
                  DataColumn(label: Text('Total Calories')),
                  DataColumn(label: Text('Tracked Time')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List<DataRow>.generate(meals.length, (index) {
                  final meal = meals[index];
                  final proteinCalories = meal.protein * 4;
                  final fatsCalories = meal.fats * 9;
                  final carbsCalories = meal.carbs * 4;
                  final totalCalories = proteinCalories + fatsCalories + carbsCalories;

                  return DataRow(cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(meal.name)),
                    DataCell(Text(meal.type)),
                    DataCell(Text(meal.protein.toString())),
                    DataCell(Text(meal.fats.toString())),
                    DataCell(Text(meal.carbs.toString())),
                    DataCell(Text(totalCalories.toString())),
                    DataCell(Text(meal.trackedTime.toString())),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Meal'),
                                content: const Text('Are you sure you want to delete this meal?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteMeal(snapshot.data!.docs[index].id, context);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]);
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
