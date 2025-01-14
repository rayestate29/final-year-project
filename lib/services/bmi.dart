import 'package:flutter/material.dart';

enum MeasurementSystem { metric, imperial }

class HealthCalculator extends StatefulWidget {
  const HealthCalculator({super.key});

  @override
  State<HealthCalculator> createState() => _HealthCalculatorState();
}

class _HealthCalculatorState extends State<HealthCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _gender = 'Male';
  double _bmi = 0;
  double _bmr = 0;
  double _tdee = 0;
  String _status = '';
  String _healthTips = '';
  MeasurementSystem _measurementSystem = MeasurementSystem.metric;

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (_measurementSystem == MeasurementSystem.metric) {
      height /= 100; // convert height from cm to meters
    } else {
      height *= 0.0254; // convert height from inches to meters
      weight *= 0.453592; // convert weight from pounds to kg
    }

    if (height <= 0 || weight <= 0) {
      setState(() {
        _bmi = 0;
        _status = 'Please enter valid height and weight';
        _healthTips = '';
      });
      return;
    }

    double bmi = weight / (height * height);
    setState(() {
      _bmi = bmi;
      if (bmi < 18.5) {
        _status = 'Underweight';
        _healthTips =
            'To improve your condition, consider consuming more nutrient-dense foods, including lean proteins, whole grains, fruits, and vegetables. Additionally, regular strength training exercises can help build muscle mass.';
      } else if (bmi >= 18.5 && bmi < 25.0) {
        _status = 'Normal weight';
        _healthTips =
            'To maintain your condition, focus on a balanced diet rich in fruits, vegetables, lean proteins, and whole grains. Regular physical activity such as walking, jogging, or swimming can also contribute to overall health.';
      } else if (bmi >= 25.0 && bmi < 30.0) {
        _status = 'Pre-obesity';
        _healthTips =
            'To prevent obesity-related health issues, aim for weight loss through a combination of healthy eating habits and regular exercise. Reduce the intake of high-calorie and processed foods, and increase physical activity levels.';
      } else if (bmi >= 30.0 && bmi < 35.0) {
        _status = 'Obesity class I';
        _healthTips =
            'For obesity management, consult with a healthcare professional to develop a personalized plan that includes dietary changes, increased physical activity, and possibly medication or other interventions.';
      } else if (bmi >= 35.0 && bmi < 40.0) {
        _status = 'Obesity class II';
        _healthTips =
            'Consider seeking medical advice for obesity treatment, which may include more intensive lifestyle modifications, prescription medications, or bariatric surgery, depending on individual health needs.';
      } else {
        _status = 'Obesity class III';
        _healthTips =
            'For severe obesity, consult with a healthcare provider to explore comprehensive treatment options, including medical interventions such as bariatric surgery, and ongoing support for long-term weight management.';
      }
    });
  }

  void _calculateBMR() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;
    int age = int.tryParse(_ageController.text) ?? 0;

    if (_measurementSystem == MeasurementSystem.imperial) {
      height *= 2.54; // convert height from inches to cm
      weight *= 0.453592; // convert weight from pounds to kg
    }

    if (height <= 0 || weight <= 0 || age <= 0) {
      setState(() {
        _bmr = 0;
      });
      return;
    }

    double bmr;
    if (_gender == 'Male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    setState(() {
      _bmr = bmr;
    });
  }

  void _calculateTDEE(double activityLevel) {
    setState(() {
      _tdee = _bmr * activityLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEALTH CALCULATOR',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Measurement System:'),
                        const SizedBox(width: 10),
                        DropdownButton<MeasurementSystem>(
                          value: _measurementSystem,
                          onChanged: (value) {
                            setState(() {
                              _measurementSystem = value!;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: MeasurementSystem.metric,
                              child: Text('Metric'),
                            ),
                            DropdownMenuItem(
                              value: MeasurementSystem.imperial,
                              child: Text('Imperial'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('Gender:'),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: _measurementSystem == MeasurementSystem.metric
                            ? 'Height (cm)'
                            : 'Height (in)',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: _measurementSystem == MeasurementSystem.metric
                            ? 'Weight (kg)'
                            : 'Weight (lbs)',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'CALCULATE BMI',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'BMI: ${_bmi.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Status: $_status',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _healthTips,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBMR,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: const RoundedRectangleBorder( ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Calculate BMR',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'BMR: ${_bmr.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'BMR (Basal Metabolic Rate) is the number of calories your body needs to perform basic life-sustaining functions like breathing and digestion.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ACTIVITY LEVEL: SELECT BELOW',
                      style: TextStyle(fontSize: 19),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () => _calculateTDEE(1.2),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: Colors.lightBlueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          ),
                          child: const Text(
                            'Sedentary (little or no exercise)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),                      
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _calculateTDEE(1.375),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: Colors.lightBlueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          ),
                          child: const Text(
                            'Lightly active (light exercise/sports 1-3 days/week)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _calculateTDEE(1.55),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                             backgroundColor: Colors.lightBlueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          ),
                          child: const Text(
                            'Moderately active (moderate exercise/sports 3-5 days/week)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _calculateTDEE(1.725),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: Colors.lightBlueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          ),
                          child: const Text(
                            'Very active (hard exercise/sports 6-7 days/week)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _calculateTDEE(1.9),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: Colors.lightBlueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          ),
                          child: const Text(
                            'Super active (very hard exercise/physical job)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'TDEE: ${_tdee.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'TDEE (Total Daily Energy Expenditure) is an estimate of the number of calories you burn per day when exercise is taken into account. This helps in planning dietary intake based on activity level.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
