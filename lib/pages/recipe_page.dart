import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String _selectedPage = 'Breakfast';
  final TextEditingController _searchController = TextEditingController();
  List<Meal> _displayedMeals = [];

  final List<Meal> _allMeals = [

    Meal(
  title: 'Koko (Millet Porridge)',
  description: 'A traditional Ghanaian breakfast made from fermented millet, often served with sugar, milk, or bread.',
  imageUrl: 'lib/assets/foodr/koko.jpg',
  backgroundColor: Colors.white,
  ingredients: ['1 cup millet', '4 cups water', '1 tbsp grated ginger', '1 tbsp ground cloves', 'sugar to taste', 'milk (optional)'],
  preparationTime: '20 minutes (plus soaking)',
  instructions: ['Soak millet overnight', 'blend with ginger and cloves', 'cook with water until thickened', 'sweeten to taste.'],
  servingSize: 'Serves 4',
  category: 'Breakfast',
),

Meal(
  title: 'Rice Water',
  description: 'A simple and nourishing breakfast porridge made from rice, often flavored with nutmeg and sweetened to taste.',
  imageUrl: 'lib/assets/foodr/ricewater.jpg',
  backgroundColor: Colors.brown.withOpacity(0.1),
  ingredients: ['1 cup rice', '5-6 cups water', '1 tsp salt', '½ tsp nutmeg', 'sugar or honey', 'milk (optional)'],
  preparationTime: '32 minutes',
  instructions: ['Boil rice in water until soft', 'add salt and nutmeg', 'sweeten', 'serve with milk.'],
  servingSize: '3 servings',
  category: 'Breakfast',
),

Meal(
  title: 'Bofrot (Ghanaian Doughnuts)',
  description: 'Sweet, deep-fried dough balls that are crispy on the outside and soft on the inside, often enjoyed as a snack or breakfast.',
  imageUrl: 'lib/assets/foodr/bofrot.jpg',
  backgroundColor: Colors.green.withOpacity(0.1),
  ingredients: ['2 cups flour', '½ cup sugar', '1 tsp yeast', '½ tsp salt', '1 cup water', 'oil for frying'],
  preparationTime: '2 hours (including rising time)',
  instructions: ['Mix dry ingredients', 'add water to form dough', 'let rise', 'fry until golden brown.'],
  servingSize: '12-14 pieces',
  category: 'Breakfast',
),

Meal(
  title: 'Koose (Black-Eyed Pea Fritters)',
  description: 'Savory fritters made from black-eyed peas, spiced with onions and peppers, and deep-fried until golden.',
  imageUrl: 'lib/assets/foodr/koose.jpg',
  backgroundColor: Colors.red.withOpacity(0.1),
  ingredients: ['2 cups black-eyed peas', '1 onion', '1 bell pepper', 'salt', 'oil for frying'],
  preparationTime: '1 hour',
  instructions: ['Blend soaked peas with onion and pepper', 'season', 'fry spoonfuls of batter.'],
  servingSize: '15 fritters',
  category: 'Breakfast',
),

Meal(
  title: 'Oat Porridge',
  description: 'A warm and filling porridge made from oats, often sweetened and served with milk.',
  imageUrl: 'lib/assets/foodr/oat.jpg',
  backgroundColor: Colors.yellow.withOpacity(0.1),
  ingredients: ['1 cup oats', '2 cups water or milk', 'sugar or honey', 'pinch of salt'],
  preparationTime: '10 minutes',
  instructions: ['Cook oats with water or milk until thickened', 'sweeten to taste.'],
  servingSize: '2 servings',
  category: 'Breakfast',
),

Meal(
  title: 'Hausa Koko',
  description: 'A spicy millet porridge flavored with ginger and cloves, popular in Northern Ghana.',
  imageUrl: 'lib/assets/foodr/hausakoko.jpg',
  backgroundColor: Colors.orange.withOpacity(0.1),
  ingredients: ['1 cup millet', '4 cups water', '1 tbsp ginger', '1 tbsp cloves', 'sugar'],
  preparationTime: '20 minutes (plus soaking)',
  instructions: ['Soak millet', 'blend with spices', 'cook until thick', 'sweeten to taste.'],
  servingSize: '4 servings',
  category: 'Breakfast',
),

Meal(
  title: 'Gari Soakings',
  description: 'A quick and refreshing meal made from gari (fermented cassava), soaked in water or milk, and sweetened.',
  imageUrl: 'lib/assets/foodr/gari.jpg',
  backgroundColor: Colors.brown.withOpacity(0.1),
  ingredients: ['1 cup gari', '1 cup water or milk', 'sugar', 'peanuts', 'milk powder'],
  preparationTime: '5 minutes',
  instructions: ['Soak gari in water or milk', 'sweeten', 'top with peanuts and milk powder.'],
  servingSize: '2 servings',
  category: 'Breakfast',
),

Meal(
  title: 'Tatale (Plantain Pancakes)',
  description: 'Sweet and savory pancakes made from ripe plantains, spiced with ginger and onions.',
  imageUrl: 'lib/assets/foodr/tatale.jpg',
  backgroundColor: Colors.green.withOpacity(0.1),
  ingredients: ['3 ripe plantains', '1 onion', '1 tsp ginger', 'flour', 'salt'],
  preparationTime: '30 minutes',
  instructions: ['Mash plantains', 'mix with chopped onion and ginger', 'add flour and salt', 'fry in oil.'],
  servingSize: '6 pancakes',
  category: 'Breakfast',
),

Meal(
  title: 'Tom Brown',
  description: 'A nutritious porridge made from roasted maize and peanuts, often enjoyed as a breakfast meal.',
  imageUrl: 'lib/assets/foodr/tombrown.jpg',
  backgroundColor: Colors.orange.withOpacity(0.1),
  ingredients: ['1 cup roasted maize flour', '3 cups water', 'sugar', 'milk'],
  preparationTime: '15 minutes',
  instructions: ['Mix maize flour with water', 'cook until thick', 'sweeten', 'add milk.'],
  servingSize: '3 servings',
  category: 'Breakfast',
),

Meal(
  title: 'Yam and Egg Sauce',
  description: 'Boiled yam served with a savory tomato and egg sauce.',
  imageUrl: 'lib/assets/foodr/yam&eggs.jpg',
  backgroundColor: Colors.yellow.withOpacity(0.1),
  ingredients: ['1 yam', '3 eggs', '2 tomatoes', '1 onion', 'spices'],
  preparationTime: '45 minutes',
  instructions: ['Boil yam', 'prepare sauce with tomatoes, onions, and spices', 'scramble eggs into sauce.'],
  servingSize: '4 servings',
  category: 'Breakfast',
),

Meal(
  title: 'Jollof Rice',
  description: 'A popular West African dish made with rice, tomatoes, and spices, often served with meat or fish.',
  imageUrl: 'lib/assets/foodr/jollof.jpg',
  backgroundColor: Colors.orange.withOpacity(0.1),
  ingredients: ['2 cups rice', '1 can tomato paste', '2 tomatoes', '1 onion', '1 bell pepper', '2 cups chicken stock', 'spices'],
  preparationTime: '1 hour',
  instructions: ['Blend tomatoes, onion, and pepper', 'cook with tomato paste and spices', 'add rice and stock', 'simmer until done.'],
  servingSize: 'Serves 6',
  category: 'Lunch',
),

Meal(
  title: 'Waakye',
  description: 'A traditional Ghanaian dish of rice and beans cooked with waakye leaves for added flavor and color.',
  imageUrl: 'lib/assets/foodr/waakye.jpg',
  backgroundColor: Colors.brown.withOpacity(0.1),
  ingredients: ['2 cups rice', '1 cup black-eyed peas', 'waakye leaves', 'salt'],
  preparationTime: '1 hour 30 minutes',
  instructions: ['Cook peas with waakye leaves', 'add rice and cook until done.'],
  servingSize: 'Serves 6',
  category: 'Lunch',
),

Meal(
  title: 'Kontomire Stew',
  description: 'A rich and flavorful stew made with cocoyam leaves, often served with boiled plantains or rice.',
  imageUrl: 'lib/assets/foodr/kontonmire.jpg',
  backgroundColor: Colors.green.withOpacity(0.1),
  ingredients: ['1 bunch kontomire leaves (cocoyam leaves)', 'palm oil', '1 onion', 'tomatoes', 'fish', 'spices'],
  preparationTime: '45 minutes',
  instructions: ['Fry onion and tomatoes in palm oil', 'add fish and spices', 'add chopped leaves', 'cook until tender.'],
  servingSize: 'Serves 5',
  category: 'Lunch',
),

Meal(
  title: 'Red Red (Bean Stew with Fried Plantains)',
  description: 'A hearty bean stew served with fried plantains, a favorite lunch dish in Ghana.',
  imageUrl: 'lib/assets/foodr/red red.jpg',
  backgroundColor: Colors.red.withOpacity(0.1),
  ingredients: ['2 cups black-eyed peas', 'palm oil', '1 onion', 'tomatoes', '3 plantains', 'spices'],
  preparationTime: '1 hour',
  instructions: ['Cook beans', 'prepare stew with palm oil, onions, and tomatoes', 'fry plantains.'],
  servingSize: 'Serves 4',
  category: 'Lunch',
),

Meal(
  title: 'Kelewele (Spicy Fried Plantains)',
  description: 'Bite-sized pieces of ripe plantains seasoned with spices and fried until crispy.',
  imageUrl: 'lib/assets/foodr/kelewele.jpg',
  backgroundColor: Colors.yellow.withOpacity(0.1),
  ingredients: ['3 ripe plantains', 'ginger', 'garlic', 'pepper', 'salt', 'oil for frying'],
  preparationTime: '20 minutes',
  instructions: ['Season plantain pieces', 'fry until golden brown.'],
  servingSize: 'Serves 3',
  category: 'Lunch',
),

Meal(
  title: 'Fufu with Light Soup',
  description: 'A classic Ghanaian dish of pounded cassava and plantain served with a light and flavorful soup.',
  imageUrl: 'lib/assets/foodr/fufu&lightsoup.jpg',
  backgroundColor: Colors.green.withOpacity(0.1),
  ingredients: ['4 plantains', '2 cassava', '1 chicken', 'tomatoes', 'peppers', 'spices'],
  preparationTime: '1 hour 30 minutes',
  instructions: ['Boil and pound plantains and cassava into a dough', 'cook chicken with spices and vegetables to make soup.'],
  servingSize: 'Serves 4',
  category: 'Dinner',
),

Meal(
  title: 'Banku and Okra Stew',
  description: 'A staple dish made from fermented corn and cassava dough served with a rich okra stew.',
  imageUrl: 'lib/assets/foodr/banku&o.jpg',
  backgroundColor: Colors.orange.withOpacity(0.1),
  ingredients: ['Corn dough', 'cassava dough', 'okra', 'palm oil', 'fish', 'spices'],
  preparationTime: '1 hour 20 minutes',
  instructions: ['Mix and cook doughs to form banku', 'prepare okra stew with fish and spices.'],
  servingSize: 'Serves 6',
  category: 'Dinner',
),

Meal(
  title: 'Kenkey and Fish',
  description: 'Fermented corn dough cooked in corn husks and served with grilled or fried fish and spicy sauce.',
  imageUrl: 'lib/assets/foodr/kenkey&fish.jpg',
  backgroundColor: Colors.yellow.withOpacity(0.1),
  ingredients: ['Corn dough, fermented for 3 days', 'fish', 'tomatoes', 'peppers', 'onions'],
  preparationTime: '1 hour',
  instructions: ['Cook dough wrapped in corn husks', 'grill or fry fish', 'prepare spicy sauce.'],
  servingSize: 'Serves 5',
  category: 'Dinner',
),

Meal(
  title: 'Okro Soup',
  description: 'A hearty soup made with okra, meat, and spices, often served with fufu or rice.',
  imageUrl: 'lib/assets/foodr/okrosoup.jpg',
  backgroundColor: Colors.green.withOpacity(0.1),
  ingredients: ['1 lb beef or chicken', '1 onion', '2 tomatoes', '1 cup chopped okra', '2 cups broth', 'spices'],
  preparationTime: '1 hour',
  instructions: ['Cook meat with onion and tomatoes', 'add okra and broth', 'season to taste.'],
  servingSize: 'Serves 4',
  category: 'Dinner',
),

Meal(
  title: 'Groundnut Soup',
  description: 'A creamy soup made from groundnuts (peanuts), meat, and spices, often served with rice or fufu.',
  imageUrl: 'lib/assets/foodr/groundnuts.jpg',
  backgroundColor: Colors.brown.withOpacity(0.1),
  ingredients: ['1 cup groundnuts', '1 lb meat (chicken, beef, or goat)', '2 tomatoes', '1 onion', '2 cups broth', 'spices'],
  preparationTime: '1 hour 30 minutes',
  instructions: ['Blend groundnuts with tomatoes and onion', 'cook meat, add blended mixture and broth', 'simmer until thickened.'],
  servingSize: 'Serves 4',
  category: 'Dinner',
),

Meal(
  title: 'Palm Nut Soup',
  description: 'A rich and flavorful soup made from palm nuts, often served with fufu or rice.',
  imageUrl: 'lib/assets/foodr/palmnutsoup.jpg',
  backgroundColor: Colors.red.withOpacity(0.1),
  ingredients: ['2 cups palm nut pulp', '1 lb meat or fish', '2 tomatoes', '1 onion', '2 cups broth', 'spices'],
  preparationTime: '2 hours',
  instructions: ['Boil palm nut pulp with meat or fish and onion', 'blend tomatoes and add to pot', 'season to taste.'],
  servingSize: 'Serves 6',
  category: 'Dinner',
),

Meal(
  title: 'Sobolo',
  description: 'A refreshing hibiscus drink infused with ginger, lemon, and spices, popular in Ghana.',
  imageUrl: 'lib/assets/foodr/sobolo.jpg',
  backgroundColor: Colors.red.withOpacity(0.1),
  ingredients: ['2 cups dried hibiscus petals', '4 cups water', 'ginger', 'lemon', 'sugar'],
  preparationTime: '30 minutes (plus chilling)',
  instructions: ['Boil hibiscus petals with water', 'add ginger and lemon', 'sweeten and chill.'],
  servingSize: 'Serves 4',
  category: 'Beverages',
),

Meal(
  title: 'Brukina',
  description: 'A creamy and sweet millet drink flavored with spices like ginger and vanilla, a popular street beverage in Ghana.',
  imageUrl: 'lib/assets/foodr/brukina.jpg',
  backgroundColor: Colors.brown.withOpacity(0.1),
  ingredients: ['1 cup millet', '4 cups water', '1 cup milk', 'sugar', 'ginger', 'vanilla'],
  preparationTime: '1 hour 30 minutes (plus chilling)',
  instructions: ['Boil millet with water until soft', 'blend and strain', 'add milk, sugar, and flavorings', 'chill before serving.'],
  servingSize: 'Serves 6',
  category: 'Beverages',
),

Meal(
  title: 'Soya Milk',
  description: 'A nutritious and creamy beverage made from soybeans, often flavored with vanilla and sweetened to taste.',
  imageUrl: 'lib/assets/foodr/soyamilk.jpg',
  backgroundColor: Colors.yellow.withOpacity(0.1),
  ingredients: ['1 cup soybeans', '4 cups water', 'sugar', 'vanilla'],
  preparationTime: '12 hours (including soaking)',
  instructions: ['Soak soybeans overnight', 'blend with water', 'strain', 'sweeten and add vanilla.'],
  servingSize: 'Serves 4',
  category: 'Beverages',
),

  
    // Add more meals here...
  ];

  final List<Meal> _savedMeals = [];

  @override
  void initState() {
    super.initState();
    _filterMeals();
  }

  void _filterMeals() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _displayedMeals = _allMeals.where((meal) => meal.category == _selectedPage).toList();
      } else {
        _displayedMeals = _allMeals.where((meal) =>
            meal.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
      }
    });
  }

  void _navigateTo(String page) {
    setState(() {
      _selectedPage = page;
      _filterMeals();
    });
    Navigator.of(context).pop(); // Close the drawer
  }

  void _toggleLike(Meal meal) {
    setState(() {
      meal.isLiked = !meal.isLiked;
      if (meal.isLiked) {
        _savedMeals.add(meal);
      } else {
        _savedMeals.remove(meal);
      }
    });
  }

  // Widget to build the grid of meal cards
  Widget _buildMealGrid(List<Meal> meals) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 50,
        ),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Container(
            decoration: BoxDecoration(
              color: meal.backgroundColor,
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
                      height: 200, // Height of the image
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(meal.imageUrl), // Load image from assets
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: IconButton(
                        icon: Icon(
                          meal.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: meal.isLiked ? Colors.red : Colors.white,
                        ),
                        onPressed: () => _toggleLike(meal),
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
                        meal.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0, // Font size for the meal title
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        meal.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Make text bold
                          fontSize: 14.0, // Font size for the description
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Preparation Time: ${meal.preparationTime}', // Added preparation time
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Make text bold
                          fontSize: 12.0, // Font size for preparation time
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ingredients: ${meal.ingredients.join(', ')}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Make text bold
                          fontSize: 12.0, // Font size for ingredients
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Instructions: ${meal.instructions.join(', ')}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Make text bold
                          fontSize: 12.0, // Font size for instructions
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Serving Size: ${meal.servingSize}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // Make text bold
                          fontSize: 12.0, // Font size for serving size
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
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _filterMeals(),
              ),
            ),
          ),
        ),
        Expanded(child: _buildMealGrid(_displayedMeals)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Search Meals', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('Breakfast'),
              onTap: () => _navigateTo('Breakfast'),
            ),
            ListTile(
              title: const Text('Lunch'),
              onTap: () => _navigateTo('Lunch'),
            ),
            ListTile(
              title: const Text('Dinner'),
              onTap: () => _navigateTo('Dinner'),
            ),
            ListTile(
              title: const Text('Beverages'),
              onTap: () => _navigateTo('Beverages'),
            ),
            ListTile(
              title: const Text('Saved Meals'),
              onTap: () => _navigateTo('Saved Meals'),
            ),
          ],
        ),
      ),
      body: _selectedPage == 'Saved Meals'
          ? _buildMealGrid(_savedMeals)
          : _buildPage(),
    );
  }
}

class Meal {
  final String title;
  final String description;
  final String imageUrl;
  final Color backgroundColor;
  final List<String> ingredients;
  final String preparationTime;
  final List<String> instructions;
  final String servingSize;
  final String category;
  bool isLiked = false;

  Meal({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.backgroundColor,
    required this.ingredients,
    required this.preparationTime,
    required this.instructions,
    required this.servingSize,
    required this.category,
  });
}
