
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
