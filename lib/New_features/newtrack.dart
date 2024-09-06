import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class CaloriesPage extends StatefulWidget {
  const CaloriesPage({super.key});

  State<CaloriesPage> createState() => _CaloriesPageState();
}

class _CaloriesPageState extends State<CaloriesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Map<String, dynamic>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calories Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _performSearch,
          ),
        ],
      ),
      drawer: const MealDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search meals',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchText = '';
                      _searchResults.clear();
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.trim();
                });
                _performSearch();
              },
            ),
            const SizedBox(height: 20.0),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  void _performSearch() async {
    if (_searchText.isNotEmpty) {
      try {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('foods')
            .where('mealName', isGreaterThanOrEqualTo: _searchText)
            .where('mealName', isLessThanOrEqualTo: '$_searchText\uf8ff')
            .get();

        setState(() {
          _searchResults = querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
      } catch (e) {
        print('Error searching for meals: $e');
      }
    }
  }

  Widget _buildSearchResults() {
    if (_searchText.isEmpty) {
      return Container();
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found for "$_searchText"'),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _searchResults.map((meal) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MealDetailsPage(meal: meal),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal['mealName'],
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Total Calories: ${meal['totalCalories']} kcal',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Serving Size: ${meal['servingSize']}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Weight: ${meal['weight']} g',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Image.network(
                    meal['imageUrl'],
                    height: 100.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MealDetailsPage extends StatefulWidget {
  final Map<String, dynamic> meal;

  const MealDetailsPage({super.key, required this.meal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  int _numServings = 1;

  @override
  Widget build(BuildContext context) {
    final int proteinCalories = widget.meal['protein'] * 4;
    final int fatsCalories = widget.meal['fats'] * 9;
    final int carbsCalories = widget.meal['carbs'] * 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal['mealName']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Meal Details',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Serving Size: ${widget.meal['servingSize']}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Text(
                    'Number of Servings: ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_numServings > 1) _numServings--;
                      });
                    },
                  ),
                  Text(
                    '$_numServings',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _numServings++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Meal Type: ${widget.meal['mealType']}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              _buildCaloriePieChart(),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaloriePieChart() {
    int proteinCalories = widget.meal['protein'] * 4 * _numServings;
    int fatsCalories = widget.meal['fats'] * 9 * _numServings;
    int carbsCalories = widget.meal['carbs'] * 4 * _numServings;
    int totalCalories = proteinCalories + fatsCalories + carbsCalories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Calories Breakdown',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12.0),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sections: _getSections(proteinCalories, fatsCalories, carbsCalories),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Proteins: $proteinCalories kcal (${((proteinCalories / totalCalories) * 100).toStringAsFixed(2)}%) - ${widget.meal['protein'] * _numServings}g',
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          'Fats: $fatsCalories kcal (${((fatsCalories / totalCalories) * 100).toStringAsFixed(2)}%) - ${widget.meal['fats'] * _numServings}g',
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          'Carbs: $carbsCalories kcal (${((carbsCalories / totalCalories) * 100).toStringAsFixed(2)}%) - ${widget.meal['carbs'] * _numServings}g',
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          'Others: ${(widget.meal['totalCalories'] - (proteinCalories + fatsCalories + carbsCalories)) * _numServings} kcal',
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  List<PieChartSectionData> _getSections(int proteinCalories, int fatsCalories, int carbsCalories) {
    return [
      PieChartSectionData(
        color: Colors.red,
        value: proteinCalories.toDouble(),
        title: '${((proteinCalories / (proteinCalories + fatsCalories + carbsCalories)) * 100).toStringAsFixed(2)}%',
        titleStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: fatsCalories.toDouble(),
        title: '${((fatsCalories / (proteinCalories + fatsCalories + carbsCalories)) * 100).toStringAsFixed(2)}%',
        titleStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: carbsCalories.toDouble(),
        title: '${((carbsCalories / (proteinCalories + fatsCalories + carbsCalories)) * 100).toStringAsFixed(2)}%',
        titleStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}

class MealDrawer extends StatelessWidget {
  const MealDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Meal Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
