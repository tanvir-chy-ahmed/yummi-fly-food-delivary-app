import 'package:flutter/material.dart';

import '../widget/widget_supports.dart';
import 'details.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = '';
  TextEditingController searchController = TextEditingController();
  int currentBannerIndex = 0;
  final PageController _bannerController = PageController();

  final List<String> banners = [
    'assets/banner1.png',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Ice Cream', 'icon': 'assets/ice-cream.png'},
    {'name': 'Pizza', 'icon': 'assets/pizza.png'},
    {'name': 'Salad', 'icon': 'assets/salad.png'},
    {'name': 'Burger', 'icon': 'assets/burger.png'},
    {'name': 'Dessert', 'icon': 'assets/dessert.jpg'},
    {'name': 'Drinks', 'icon': 'assets/drink.png'},
    {'name': 'Noodles', 'icon': 'assets/pizza.png'},
    {'name': 'Sushi', 'icon': 'assets/sushi.jpg'},
    {'name': 'Biryani', 'icon': 'assets/burger.png'},
    {'name': 'Sandwich', 'icon': 'assets/drink.png'},
  ];

  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Mix Veg Salad',
      'description': 'Spicy with Onion',
      'price': 28.0,
      'image': 'assets/salad2.png',
      'category': 'Salad',
      'rating': 4.5,
    },
    {
      'name': 'Mediterranean Chickpea Salad',
      'description': 'Honey Goat Cheese',
      'price': 28.0,
      'image': 'assets/salad2.png',
      'category': 'Salad',
      'rating': 4.8,
    },
    // Add more food items here
  ];

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredFoodItems {
    return foodItems.where((item) {
      final matchesCategory = selectedCategory.isEmpty || item['category'] == selectedCategory;
      final matchesSearch = searchController.text.isEmpty ||
          item['name'].toLowerCase().contains(searchController.text.toLowerCase()) ||
          item['description'].toLowerCase().contains(searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Widget _buildBannerSlider() {
    return Container(
      height: 180,
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() {
                currentBannerIndex = index;
              });
            },
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    banners[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: currentBannerIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: currentBannerIndex == index
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello Tanvir,', style: Appwidget.boldTextFeildStyle()),
                          SizedBox(height: 8),
                          Text('Yummi-Fly', style: Appwidget.HeadlineTextFeildStyle()),
                          Text('Discover and Get Great Food',
                              style: Appwidget.LightTextFeildStyle()),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cart()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Icon(Icons.shopping_cart_outlined, color: Colors.white),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text('2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search food...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildBannerSlider(),
            SizedBox(height: 20),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = isSelected ? '' : category['name'];
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category['icon'],
                            height: 40,
                            width: 40,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: 8),
                          Text(
                            category['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: filteredFoodItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No items found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: filteredFoodItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredFoodItems[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(item: item),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(15),
                                  ),
                                  child: Image.asset(
                                    item['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          item['description'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${item['price'].toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.amber,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  item['rating'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
