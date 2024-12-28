class Forest {
  final int id;
  final double rating;
  final String name;
  final String imageURL; // Main image
  final String imageURL2; // Secondary image
  final String imageURL3; // Tertiary image
  bool isFavorited;
  final String description;
  final String comment1; // Replacing size with comment1
  final String comment2;
  bool isSelected;
  final String entryFee; // Entry fee or ticket price
  final String openingHours; // Opening hours of the forest

  Forest({
    required this.id,
    required this.rating,
    required this.name,
    required this.comment1,  // Replacing size with comment1
    required this.comment2,
    required this.imageURL,
    required this.imageURL2,
    required this.imageURL3,
    required this.isFavorited,
    required this.description,
    required this.isSelected,
    required this.entryFee,
    required this.openingHours,
  });

  // List of Forests
  static List<Forest> forestList = [
    Forest(
      id: 0,
      rating: 4.8,
      name: 'Black River Gorges National Park',
      imageURL: 'assets/blackriver1.jpg',
      imageURL2: 'assets/blackriver2.jpg',
      imageURL3: 'assets/blackriver3.jpg',
      isFavorited: false,
      description: 'This national park is home to many endemic species and offers beautiful hiking trails and viewpoints.',
      isSelected: false,
      entryFee: 'MUR 500',
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.', // Replacing size with comment1
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.', // Replacing temperature with
      openingHours: 'Daily, 6:00 AM - 6:00 PM',
    ),
    Forest(
      id: 1,
      rating: 4.6,
      name: 'Mare aux Vacoas',
      imageURL: 'assets/mareauxvacoas1.jpg',
      imageURL2: 'assets/mareauxvacoas2.jpg',
      imageURL3: 'assets/mareauxvacoas3.jpg',
      isFavorited: false,
      description: 'Mare aux Vacoas is a beautiful forest reserve offering lush greenery and serene walking paths.',
      isSelected: false,
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.', // Replacing size with comment1
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.', // Replacing temperature with
      entryFee: 'MUR 200',
      openingHours: 'Daily, 7:00 AM - 5:00 PM',
    ),
  ];

  // Get favorited forests
  static List<Forest> getFavoritedForests() {
    return forestList.where((forest) => forest.isFavorited == true).toList();
  }

  // Get selected forests
  static List<Forest> getSelectedForests() {
    return forestList.where((forest) => forest.isSelected == true).toList();
  }
}
