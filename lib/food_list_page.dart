import 'package:flutter/material.dart';
import 'ordering/ordering_page.dart';
import 'package:mad_project_test/profile/profile.dart';

class FoodOutlet {
  final String image;
  final String name;
  final String description;
  final String rating;
  final String deliveryTime;

  FoodOutlet({
    required this.image,
    required this.name,
    required this.description,
    required this.rating,
    required this.deliveryTime,
  });
}

List<FoodOutlet> foodOutletList() {
  return [
    FoodOutlet(
      image: 'images/mcd.png',
      name: 'McDonalds',
      description: 'Fast food burgers and fries.',
      rating: "4.2",
      deliveryTime: '15 - 20 min',
    ),
    FoodOutlet(
      image: 'images/kfc.png',
      name: 'KFC',
      description: 'Fried chicken and sides.',
      rating: "4.5",
      deliveryTime: '20 - 25 min',
    ),
    FoodOutlet(
      image: 'images/ljs.png',
      name: 'Long John Silvers',
      description: 'Battered, deep-fried seafood and chicken.',
      rating: "4.9",
      deliveryTime: '5 - 10 min',
    ),
    FoodOutlet(
      image: 'images/subway.png',
      name: 'Subway',
      description: 'Fresh sandwiches made to order.',
      rating: "4.3",
      deliveryTime: '10 - 15 min',
    ),
    FoodOutlet(
      image: 'images/pizzahut.png',
      name: 'Pizza Hut',
      description: 'Italian pizzas and pasta.',
      rating: "4.3",
      deliveryTime: '25 - 30 min',
    ),
    FoodOutlet(
      image: 'images/burgerking.png',
      name: 'Burger King',
      description: 'Flame-grilled burgers.',
      rating: "4.0",
      deliveryTime: '15 - 20 min',
    ),
  ];
}

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final TextEditingController searchController = TextEditingController();
  late List<FoodOutlet> allOutlets;
  late List<FoodOutlet> displayedOutlets;

  @override
  void initState() {
    super.initState();
    allOutlets = foodOutletList();
    displayedOutlets = allOutlets;
  }

  void searchFood(String query) {
    setState(() {
      displayedOutlets = allOutlets
          .where((outlet) =>
              outlet.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Food Outlets'),
            Text(
              Profile.currentUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 237, 237, 237),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: searchFood,
              decoration: InputDecoration(
                hintText: 'Search food outlets...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          searchFood('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: displayedOutlets.length,
                itemBuilder: (context, index) {
                  final outlet = displayedOutlets[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              OrderingPage(foodOutlet: outlet),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(top: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                outlet.image,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    outlet.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    outlet.description,
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 18),
                                      const SizedBox(width: 4),
                                      Text(outlet.rating),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer,
                                          color: Colors.grey, size: 18),
                                      const SizedBox(width: 4),
                                      Text(outlet.deliveryTime),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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
