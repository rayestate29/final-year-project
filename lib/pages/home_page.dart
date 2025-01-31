import 'package:finalc/pages/dash.dart';
import 'package:finalc/pages/recipe_page.dart';
import 'package:finalc/pages/track.dart';
import 'package:finalc/services/ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalc/services/bmi.dart';
import 'package:finalc/services/herbal.dart';
import 'package:finalc/New_features/newtrack.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Text(
            'LOG OUT',
            style: TextStyle(fontWeight: FontWeight.bold),),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.person),
          )
        ],
      ),
      

        body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'WELCOME TO KNUTSFORD CALORIE TRACKER',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        side: BorderSide(color: Colors.black, width: 5),
                      ),
                      elevation: 70,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: SizedBox(
                        width: 550,
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                height: 250,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/assets/images/bmi.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'HEALTH CALCULATOR',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Calculate your BMI, BMR, and TDEE based on your age, height, and weight. Track your body metrics to better understand your health and fitness needs. Use this page to tailor your nutrition and exercise plans effectively.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 190,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const HealthCalculator()));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.white)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.touch_app,
                                            color: Colors.black),
                                        Text(
                                          'CLICK HERE',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        side: BorderSide(color: Colors.black, width: 5),
                      ),
                      elevation: 70,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: SizedBox(
                        width: 550,
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                height: 250,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/assets/images/food.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'TRACK YOUR MEAL',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Track your meals and discover their calorie content effortlessly. Find the calories in various foods to manage your daily intake. Stay informed and make healthier choices with ease.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 190,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const TrackingPage()));
                                   },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.white)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.touch_app,
                                            color: Colors.black),
                                        Text(
                                          'CLICK HERE',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                    side: BorderSide(color: Colors.black, width: 5),
                  ),
                  elevation: 70,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    width: 550,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 250,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/images/fc.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'FIND MEAL RECIPES',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Discover a variety of delicious Ghanaian recipes for breakfast, lunch, dinner, and beverages. Explore traditional and modern dishes to diversify your meals. Use this page to bring authentic Ghanaian flavors to your kitchen.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 190,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const RecipePage()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.white)),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.touch_app,
                                        color: Colors.black),
                                    Text(
                                      'CLICK HERE',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Card(
                  shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(17)),
                    side: BorderSide(color: Colors.black, width: 5),
                  ),
                  elevation: 70,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    width: 550,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 250,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/images/c2.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'VIEW ACTIVITY',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Visualize your daily and weekly meal calorie intake with insightful charts. Track your progress and make informed decisions about your nutrition habits. Effortlessly monitor your calorie consumption trends for better health management.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 190,
                            child: ElevatedButton(
                              onPressed: () {
                                 Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const DashboardPage())
                                      );
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.white)),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.touch_app,
                                        color: Colors.black),
                                    Text(
                                      'CLICK HERE',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                    side: BorderSide(color: Colors.black, width: 5),
                  ),
                  elevation: 70,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    width: 550,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 250,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/images/herb.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'HERBAL REMEDIES',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Discover herbal remedies for common conditions like coughs with ease. Find natural solutions to support your well-being and health goals. Explore holistic healing options for a healthier lifestyle.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 190,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HerbalPage()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.white)),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.touch_app,
                                        color: Colors.black),
                                    Text(
                                      'CLICK HERE',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Card(
                  shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(17)),
                    side: BorderSide(color: Colors.black, width: 5),
                  ),
                  elevation: 70,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    width: 550,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 250,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/images/ai.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'AI POWERED ASSISTANT',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Get instant assistance on any topic with our AI text chatbot. Ask questions and receive helpful responses in real-time. Unlock a world of knowledge at your fingertips with ease.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 190,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.white)),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.touch_app,
                                        color: Colors.black),
                                    Text(
                                      'CLICK HERE',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),



            const SizedBox(height: 25),



            







          ],





        ),
        
      ),    
    );   
    } 
} 

    
