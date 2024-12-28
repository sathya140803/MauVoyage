class Beach {
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
  final String openingHours; // Opening hours of the beach

  Beach({
    required this.id,
    required this.rating,
    required this.name,
    required this.imageURL,
    required this.imageURL2,
    required this.imageURL3,
    required this.comment1,  // Replacing size with comment1
    required this.comment2,  // Rep
    required this.isFavorited,
    required this.description,
    required this.isSelected,
    required this.entryFee,
    required this.openingHours,
  });

  // List of Beaches
  static List<Beach> beachList = [
    Beach(
      id: 0,
      rating: 4.7,
      name: 'Blue Bay Beach',
      imageURL: 'assets/beaches/beach2.jpg',
      imageURL2: 'assets/bluebay2.jpg',
      imageURL3: 'assets/bluebay3.jpg',
      isFavorited: false,
      description: 'Blue Bay Beach is famous for its clear waters, soft white sand, and great snorkeling opportunities.',
      isSelected: false,
      entryFee: 'MUR 200',
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to nature\'s most serene moments.',
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to nature\'s most serene beauty.',
      openingHours: 'Daily, 8:00 AM - 6:00 PM',
    ),
    Beach(
      id: 1,
      rating: 4.5,
      name: 'Le Morne Beach',
      imageURL: 'assets/lemorne1.jpg',
      imageURL2: 'assets/lemorne2.jpg',
      imageURL3: 'assets/lemorne3.jpg',
      isFavorited: false,
      description: 'Le Morne Beach offers stunning views of the iconic Le Morne Mountain and excellent kite surfing spots.',
      isSelected: false,
      entryFee: 'MUR 300',
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to nature\'s most serene moments.',
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to nature\'s most serene beauty.',
      openingHours: 'Daily, 9:00 AM - 7:00 PM',
    ),
    Beach(
      id: 2,
      rating: 4.8,
      name: 'Trou aux Biches',
      imageURL: 'assets/beaches/Trou-Aux-Biches.jpg',
      imageURL2: 'assets/trouauxbiches2.jpg',
      imageURL3: 'assets/trouauxbiches3.jpg',
      isFavorited: false,
      description: 'Trou aux Biches is known for its calm waters and ideal conditions for swimming and snorkeling.',
      isSelected: false,
      entryFee: 'MUR 100',
      comment1: 'A quiet and peaceful escape, the pristine waters offer an unmatched serenity.',
      comment2: 'The golden sands stretch far and wide, creating the perfect environment for a relaxing day.',
      openingHours: 'Daily, 8:00 AM - 5:00 PM',
    ),
    Beach(
      id: 3,
      rating: 4.3,
      name: 'Grand Baie',
      imageURL: 'assets/beaches/bluebay.jpg',
      imageURL2: 'assets/grandbaie2.jpg',
      imageURL3: 'assets/grandbaie3.jpg',
      isFavorited: false,
      description: 'Grand Baie is a lively beach area with numerous restaurants, shops, and water activities.',
      isSelected: false,
      entryFee: 'MUR 150',
      comment1: 'Grand Baie is vibrant with an abundance of water sports activities and entertainment.',
      comment2: 'A bustling beach where you can enjoy both adventure and relaxation.',
      openingHours: 'Daily, 9:00 AM - 8:00 PM',
    ),
    Beach(
      id: 4,
      rating: 4.6,
      name: 'Pereybere Beach',
      imageURL: 'assets/beaches/Peyrebere.jpg',
      imageURL2: 'assets/pereybere2.jpg',
      imageURL3: 'assets/pereybere3.jpg',
      isFavorited: false,
      description: 'Pereybere Beach is a popular spot for both locals and tourists, offering clear waters and a relaxing environment.',
      isSelected: false,
      entryFee: 'MUR 50',
      comment1: 'Perfect for a day out with family or friends, enjoying both the sun and the calm sea.',
      comment2: 'A charming, small beach that never feels overcrowded, perfect for swimming.',
      openingHours: 'Daily, 7:00 AM - 6:00 PM',
    ),
    Beach(
      id: 5,
      rating: 4.4,
      name: 'Flic en Flac',
      imageURL: 'assets/beaches/flicnflck.jpg',
      imageURL2: 'assets/flicenflac2.jpg',
      imageURL3: 'assets/flicenflac3.jpg',
      isFavorited: false,
      description: 'Flic en Flac is famous for its long sandy beaches and crystal-clear waters, ideal for snorkeling and diving.',
      isSelected: false,
      entryFee: 'MUR 200',
      comment1: 'With its clear waters and vibrant marine life, it’s a diver\'s paradise.',
      comment2: 'Flic en Flac offers a great balance of relaxation and adventure, with activities for everyone.',
      openingHours: 'Daily, 8:00 AM - 7:00 PM',
    ),
  ];

  // Get favorited beaches
  static List<Beach> getFavoritedBeaches() {
    return beachList.where((beach) => beach.isFavorited == true).toList();
  }

  // Get selected beaches
  static List<Beach> getSelectedBeaches() {
    return beachList.where((beach) => beach.isSelected == true).toList();
  }
}
