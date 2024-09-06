import 'package:flutter/material.dart';

class HerbalPage extends StatefulWidget {
  const HerbalPage({super.key});

  @override
  State<HerbalPage> createState() => _HerbalPageState();
}

class _HerbalPageState extends State<HerbalPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Herbal> _displayedHerbals = [];

  final List<Herbal> _allHerbals = [
    // List of herbal remedies (same as provided earlier)


  Herbal(
    condition: 'Cough',
    imageUrl: 'lib/assets/herbal/gingertea.jpg',
    symptoms: ['Dry cough', 'Sore throat', 'Chest discomfort'],
    remedyName: 'Honey and Ginger Tea',
    ingredients: ['1 cup water', '1 tbsp honey', '1 tsp grated ginger'],
    treatmentSteps: [
      'Boil water.',
      'Add grated ginger.',
      'Let it simmer for 5 minutes.',
      'Strain and add honey.',
      'Drink while warm.'
    ],
    lifestyleTips: ['Stay hydrated', 'Avoid irritants', 'Rest your voice'],
  ),
  Herbal(
    condition: 'Headache',
    imageUrl: 'lib/assets/herbal/peppermint.jpg',
    symptoms: ['Throbbing pain', 'Sensitivity to light', 'Nausea'],
    remedyName: 'Peppermint Oil Massage',
    ingredients: ['Few drops of peppermint oil', '1 tbsp carrier oil'],
    treatmentSteps: [
      'Mix peppermint oil with carrier oil.',
      'Gently massage the temples and forehead.',
      'Relax and breathe deeply.'
    ],
    lifestyleTips: ['Stay hydrated', 'Maintain a regular sleep schedule', 'Avoid caffeine'],
  ),
  Herbal(
    condition: 'Cold',
    imageUrl: 'lib/assets/herbal/eucalyptussteam.jpg',
    symptoms: ['Runny nose', 'Sneezing', 'Congestion'],
    remedyName: 'Eucalyptus Steam Inhalation',
    ingredients: ['1 bowl hot water', 'Few drops eucalyptus oil'],
    treatmentSteps: [
      'Add eucalyptus oil to hot water.',
      'Lean over the bowl and cover head with a towel.',
      'Inhale the steam for 5-10 minutes.'
    ],
    lifestyleTips: ['Rest well', 'Stay hydrated', 'Eat warm soups'],
  ),
  Herbal(
    condition: 'Insomnia',
    imageUrl: 'lib/assets/herbal/chamomiletea.jpg',
    symptoms: ['Difficulty falling asleep', 'Waking up often during the night', 'Fatigue'],
    remedyName: 'Chamomile Tea',
    ingredients: ['1 cup water', '1 chamomile tea bag or 1 tsp dried chamomile flowers'],
    treatmentSteps: [
      'Boil water.',
      'Steep chamomile tea bag or flowers in hot water for 5 minutes.',
      'Drink before bedtime.'
    ],
    lifestyleTips: ['Maintain a regular sleep schedule', 'Create a relaxing bedtime routine', 'Avoid screens before bed'],
  ),
  Herbal(
    condition: 'Digestive Issues',
    imageUrl: 'lib/assets/herbal/gingertea.jpg',
    symptoms: ['Bloating', 'Gas', 'Indigestion'],
    remedyName: 'Ginger Tea',
    ingredients: ['1 cup water', '1 tsp grated ginger'],
    treatmentSteps: [
      'Boil water.',
      'Add grated ginger.',
      'Let it simmer for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Eat slowly', 'Avoid heavy meals', 'Stay active'],
  ),
  Herbal(
    condition: 'Sore Throat',
    imageUrl: 'lib/assets/herbal/saltwatergaggle.jpg',
    symptoms: ['Painful swallowing', 'Scratchy throat', 'Swelling'],
    remedyName: 'Salt Water Gargle',
    ingredients: ['1 cup warm water', '1 tsp salt'],
    treatmentSteps: [
      'Mix salt in warm water.',
      'Gargle the solution for 30 seconds.',
      'Repeat 2-3 times a day.'
    ],
    lifestyleTips: ['Stay hydrated', 'Avoid irritants', 'Rest your voice'],
  ),
  Herbal(
    condition: 'Anxiety',
    imageUrl: 'lib/assets/herbal/lavendertea.jpg',
    symptoms: ['Restlessness', 'Nervousness', 'Rapid heart rate'],
    remedyName: 'Lavender Tea',
    ingredients: ['1 cup water', '1 tsp dried lavender flowers'],
    treatmentSteps: [
      'Boil water.',
      'Steep lavender flowers in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Practice deep breathing', 'Engage in physical activity', 'Get adequate sleep'],
  ),
  Herbal(
    condition: 'Skin Irritation',
    imageUrl: 'lib/assets/herbal/aloevergel.jpg',
    symptoms: ['Redness', 'Itching', 'Swelling'],
    remedyName: 'Aloe Vera Gel',
    ingredients: ['Fresh aloe vera leaf'],
    treatmentSteps: [
      'Cut the aloe vera leaf and extract the gel.',
      'Apply the gel directly to the irritated skin.',
      'Leave it on for 20 minutes and rinse off.'
    ],
    lifestyleTips: ['Avoid harsh chemicals', 'Keep the skin moisturized', 'Wear breathable fabrics'],
  ),
  Herbal(
    condition: 'Nausea',
    imageUrl: 'lib/assets/herbal/pepperminttea.jpg',
    symptoms: ['Queasiness', 'Vomiting', 'Dizziness'],
    remedyName: 'Peppermint Tea',
    ingredients: ['1 cup water', '1 tsp dried peppermint leaves'],
    treatmentSteps: [
      'Boil water.',
      'Steep peppermint leaves in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Avoid strong odors', 'Eat small, frequent meals', 'Stay hydrated'],
  ),
  Herbal(
    condition: 'Arthritis',
    imageUrl: 'lib/assets/herbal/tumericmilk.jpg',
    symptoms: ['Joint pain', 'Stiffness', 'Swelling'],
    remedyName: 'Turmeric Milk',
    ingredients: ['1 cup milk', '1 tsp turmeric powder'],
    treatmentSteps: [
      'Heat milk.',
      'Add turmeric powder and stir well.',
      'Drink warm.'
    ],
    lifestyleTips: ['Stay active', 'Maintain a healthy weight', 'Practice gentle stretching'],
  ),
  Herbal(
    condition: 'Back Pain',
    imageUrl: 'lib/assets/herbal/capsaicincream.jpg',
    symptoms: ['Lower back pain', 'Stiffness', 'Muscle spasms'],
    remedyName: 'Capsaicin Cream',
    ingredients: ['Capsaicin cream (available over-the-counter)'],
    treatmentSteps: [
      'Apply a small amount of capsaicin cream to the affected area.',
      'Massage gently until absorbed.',
      'Repeat 2-3 times a day.'
    ],
    lifestyleTips: ['Maintain good posture', 'Stay active', 'Use ergonomic furniture'],
  ),
  Herbal(
    condition: 'Menstrual Cramps',
    imageUrl: 'lib/assets/herbal/fenneltea.jpg',
    symptoms: ['Lower abdominal pain', 'Bloating', 'Fatigue'],
    remedyName: 'Fennel Tea',
    ingredients: ['1 cup water', '1 tsp fennel seeds'],
    treatmentSteps: [
      'Boil water.',
      'Steep fennel seeds in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Exercise regularly', 'Apply heat to the lower abdomen', 'Stay hydrated'],
  ),
  Herbal(
    condition: 'Constipation',
    imageUrl: 'lib/assets/herbal/flaxseed.jpg',
    symptoms: ['Infrequent bowel movements', 'Hard stools', 'Bloating'],
    remedyName: 'Flaxseed Water',
    ingredients: ['1 cup water', '1 tbsp flaxseeds'],
    treatmentSteps: [
      'Soak flaxseeds in water overnight.',
      'Drink the water along with the flaxseeds in the morning.'
    ],
    lifestyleTips: ['Eat high-fiber foods', 'Stay hydrated', 'Exercise regularly'],
  ),
  Herbal(
    condition: 'Allergies',
    imageUrl: 'lib/assets/herbal/nettletea.jpg',
    symptoms: ['Sneezing', 'Itchy eyes', 'Runny nose'],
    remedyName: 'Nettle Tea',
    ingredients: ['1 cup water', '1 tsp dried nettle leaves'],
    treatmentSteps: [
      'Boil water.',
      'Steep nettle leaves in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Avoid allergens', 'Keep windows closed during high pollen seasons', 'Shower after being outdoors'],
  ),
  Herbal(
    condition: 'High Blood Pressure',
    imageUrl: 'lib/assets/herbal/hibuscustea.jpg',
    symptoms: ['Headaches', 'Dizziness', 'Shortness of breath'],
    remedyName: 'Hibiscus Tea',
    ingredients: ['1 cup water', '1 tbsp dried hibiscus petals'],
    treatmentSteps: [
      'Boil water.',
      'Steep hibiscus petals in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Limit salt intake', 'Exercise regularly', 'Maintain a healthy weight'],
  ),
  Herbal(
    condition: 'Acne',
    imageUrl: 'lib/assets/herbal/teatreeeoilspot.jpg',
    symptoms: ['Pimples', 'Redness', 'Swelling'],
    remedyName: 'Tea Tree Oil Spot Treatment',
    ingredients: ['Few drops of tea tree oil', '1 tbsp carrier oil'],
    treatmentSteps: [
      'Mix tea tree oil with carrier oil.',
      'Apply a small amount to the affected area with a cotton swab.',
      'Leave it on for a few hours or overnight and rinse off.'
    ],
    lifestyleTips: ['Cleanse your face twice daily', 'Avoid touching your face', 'Use non-comedogenic products'],
  ),
  Herbal(
    condition: 'Asthma',
    imageUrl: 'lib/assets/herbal/licoriceroot.jpg',
    symptoms: ['Shortness of breath', 'Wheezing', 'Coughing'],
    remedyName: 'Licorice Root Tea',
    ingredients: ['1 cup water', '1 tsp dried licorice root'],
    treatmentSteps: [
      'Boil water.',
      'Steep licorice root in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Avoid triggers', 'Use a humidifier', 'Practice breathing exercises'],
  ),
  Herbal(
    condition: 'Fatigue',
    imageUrl: 'lib/assets/herbal/ginsengtea.jpg',
    symptoms: ['Tiredness', 'Lack of energy', 'Difficulty concentrating'],
    remedyName: 'Ginseng Tea',
    ingredients: ['1 cup water', '1 tsp dried ginseng root'],
    treatmentSteps: [
      'Boil water.',
      'Steep ginseng root in hot water for 5 minutes.',
      'Strain and drink.'
    ],
    lifestyleTips: ['Get adequate sleep', 'Eat a balanced diet', 'Exercise regularly'],
  ),
  Herbal(
    condition: 'Eczema',
    imageUrl: 'lib/assets/herbal/oatmeal.jpg',
    symptoms: ['Dry skin', 'Itching', 'Red patches'],
    remedyName: 'Oatmeal Bath',
    ingredients: ['1 cup colloidal oatmeal', 'Warm bath water'],
    treatmentSteps: [
      'Add colloidal oatmeal to warm bath water.',
      'Soak in the bath for 15-20 minutes.',
      'Pat skin dry and moisturize.'
    ],
    lifestyleTips: ['Moisturize regularly', 'Avoid harsh soaps', 'Wear soft, breathable fabrics'],
  ),
  Herbal(
    condition: 'Toothache',
    imageUrl: 'lib/assets/herbal/cloveoil.jpg',
    symptoms: ['Sharp pain', 'Swelling', 'Sensitivity to hot or cold'],
    remedyName: 'Clove Oil',
    ingredients: ['Few drops of clove oil', 'Cotton ball'],
    treatmentSteps: [
      'Apply a few drops of clove oil to a cotton ball.',
      'Place the cotton ball on the affected tooth.',
      'Leave it on for a few minutes.'
    ],
    lifestyleTips: ['Maintain good oral hygiene', 'Avoid sugary foods', 'Visit your dentist regularly'],
  ),
  // ... (other remedies)
];

   
    


  final List<Herbal> _savedHerbals = [];

  @override
  void initState() {
    super.initState();
    _filterHerbals();
  }

  void _filterHerbals() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _displayedHerbals = List.from(_allHerbals);
      } else {
        _displayedHerbals = _allHerbals.where((herbal) =>
            herbal.condition.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
      }
    });
  }

  void _toggleLike(Herbal herbal) {
    setState(() {
      herbal.isLiked = !herbal.isLiked;
      if (herbal.isLiked) {
        _savedHerbals.add(herbal);
      } else {
        _savedHerbals.remove(herbal);
      }
    });
  }

  // Widget to build the grid of herbal remedy cards
  Widget _buildHerbalGrid(List<Herbal> herbals) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 50,
        ),
        itemCount: herbals.length,
        itemBuilder: (context, index) {
          final herbal = herbals[index];
          return Container(
            decoration: BoxDecoration(
              // Changed the color of the container to white
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 220, // Height of the image
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17),
                        ),
                        image: DecorationImage(
                          image: AssetImage(herbal.imageUrl), // Load image from assets
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: IconButton(
                        icon: Icon(
                          herbal.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: herbal.isLiked ? Colors.red : Colors.white,
                        ),
                        onPressed: () => _toggleLike(herbal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        herbal.remedyName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0, // Font size for the remedy name
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Condition: ${herbal.condition}',
                        style: const TextStyle(
                          fontSize: 14.0, // Font size for the condition
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Symptoms: ${herbal.symptoms.join(', ')}',
                        style: const TextStyle(
                          fontSize: 12.0, // Font size for symptoms
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ingredients: ${herbal.ingredients.join(', ')}',
                        style: const TextStyle(
                          fontSize: 12.0, // Font size for ingredients
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Steps: ${herbal.treatmentSteps.join(', ')}',
                        style: const TextStyle(
                          fontSize: 12.0, // Font size for steps
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Tips: ${herbal.lifestyleTips.join(', ')}',
                        style: const TextStyle(
                          fontSize: 12.0, // Font size for tips
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _filterHerbals(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SavedHerbalsPage(savedHerbals: _savedHerbals),
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(child: _buildHerbalGrid(_displayedHerbals)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Herbal Remedies Page'),
      ),
      body: _buildPage(),
    );
  }
}

class SavedHerbalsPage extends StatelessWidget {
  final List<Herbal> savedHerbals;

  const SavedHerbalsPage({super.key, required this.savedHerbals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Herbal Remedies'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 50,
          ),
          itemCount: savedHerbals.length,
          itemBuilder: (context, index) {
            final herbal = savedHerbals[index];
            return Container(
              decoration: BoxDecoration(
                // Changed the color of the container to white
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 220, // Height of the image
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),
                      image: DecorationImage(
                        image: AssetImage(herbal.imageUrl), // Load image from assets
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          herbal.remedyName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0, // Font size for the remedy name
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Condition: ${herbal.condition}',
                          style: const TextStyle(
                            fontSize: 14.0, // Font size for the condition
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Symptoms: ${herbal.symptoms.join(', ')}',
                          style: const TextStyle(
                            fontSize: 12.0, // Font size for symptoms
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Ingredients: ${herbal.ingredients.join(', ')}',
                          style: const TextStyle(
                            fontSize: 12.0, // Font size for ingredients
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Steps: ${herbal.treatmentSteps.join(', ')}',
                          style: const TextStyle(
                            fontSize: 12.0, // Font size for steps
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Tips: ${herbal.lifestyleTips.join(', ')}',
                          style: const TextStyle(
                            fontSize: 12.0, // Font size for tips
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Herbal model
class Herbal {
  final String condition;
  final String imageUrl;
  final List<String> symptoms;
  final String remedyName;
  final List<String> ingredients;
  final List<String> treatmentSteps;
  final List<String> lifestyleTips;
  bool isLiked;

  Herbal({
    required this.condition,
    required this.imageUrl,
    required this.symptoms,
    required this.remedyName,
    required this.ingredients,
    required this.treatmentSteps,
    required this.lifestyleTips,
    this.isLiked = false,
  });
}
