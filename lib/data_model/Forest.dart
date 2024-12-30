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
    required this.comment1, // Replacing size with comment1
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

  static List<Forest> forestList = [
    Forest(
      id: 0,
      rating: 4.8,
      name: 'Black River Gorges National Park',
      imageURL: 'assets/images/riverenoir.jpg',
      imageURL2: 'assets/blackriver2.jpg',
      imageURL3: 'assets/blackriver3.jpg',
      isFavorited: false,
      description:
          'This national park is home to many endemic species and offers beautiful hiking trails and viewpoints.',
      isSelected: false,
      entryFee: 'MUR 500',
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.',
      comment2:
          'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.',
      openingHours: 'Daily, 6:00 AM - 6:00 PM',
    ),
    Forest(
      id: 1,
      rating: 4.6,
      name: 'Mare aux Vacoas',
      imageURL: 'assets/images/mareaux.jpg',
      imageURL2: 'assets/mareauxvacoas2.jpg',
      imageURL3: 'assets/mareauxvacoas3.jpg',
      isFavorited: false,
      description:
          'Mare aux Vacoas is a beautiful forest reserve offering lush greenery and serene walking paths.',
      isSelected: false,
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.',
      comment2:
          'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.',
      entryFee: 'MUR 200',
      openingHours: 'Daily, 7:00 AM - 5:00 PM',
    ),
    // Adding more forests
    Forest(
      id: 2,
      rating: 4.7,
      name: 'Alexandra falls',
      imageURL: 'assets/images/alex.jpg',
      imageURL2: 'assets/blackriverpeak2.jpg',
      imageURL3: 'assets/blackriverpeak3.jpg',
      isFavorited: false,
      description:
          'A stunning hike offering panoramic views of the western coast of Mauritius.',
      isSelected: false,
      comment1:
          'The journey up Black River Peak challenges both the mind and body, but the reward is a spectacular view over the island’s most breathtaking landscapes.',
      comment2:
          'This is the perfect spot for nature lovers who seek adventure and the serenity of untouched wilderness.',
      entryFee: 'MUR 400',
      openingHours: 'Daily, 6:00 AM - 6:00 PM',
    ),
    Forest(
      id: 3,
      rating: 4.5,
      name: 'piton de la petite rivière noire',
      imageURL: 'assets/images/pitondela.jpg',
      imageURL2: 'assets/pitonpetiterivierenoire2.jpg',
      imageURL3: 'assets/pitonpetiterivierenoire3.jpg',
      isFavorited: false,
      description:
          'Known for its rugged terrain, this is one of the most challenging and rewarding hikes on the island.',
      isSelected: false,
      comment1:
          'Piton de la Petite Riviere Noire is not for the faint of heart, but those who make it to the summit are treated to unparalleled views of the island’s heart.',
      comment2:
          'The forest surrounding the peak offers a variety of flora and fauna, making it a paradise for ecotourism.',
      entryFee: 'MUR 350',
      openingHours: 'Daily, 5:00 AM - 7:00 PM',
    ),
    Forest(
      id: 4,
      rating: 4.3,
      name: 'le morne bradant.jpg',
      imageURL: 'assets/images/lebradant.jpg',
      imageURL2: 'assets/lemornebrabant2.jpg',
      imageURL3: 'assets/lemornebrabant3.jpg',
      isFavorited: false,
      description:
          'A UNESCO World Heritage site known for its historical significance and amazing views from the summit.',
      isSelected: false,
      comment1:
          'The climb up Le Morne Brabant offers a powerful mix of history and nature, revealing a story of courage and resilience.',
      comment2:
          'From the summit, the views stretch far beyond the island, offering a breathtaking panorama of the coastline and lagoon.',
      entryFee: 'MUR 300',
      openingHours: 'Daily, 6:00 AM - 5:00 PM',
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
