class NightClubEvent {
  final int id;
  final double rating;
  final String category; // Example: "Nightclub", "Beach Party", "Live Concert"
  final String name;
  final String imageURL; // Main image
  final String imageURL2; // Secondary image
  final String imageURL3; // Tertiary image
  bool isFavorited;
  final String description;
  bool isSelected;
  final String comment1; // User comment or review 1
  final String comment2; // User comment or review 2
  final String dressCode; // Example: "Casual", "Formal", "Smart Casual"
  final String entryFee; // Entry fee or ticket price
  final String eventDate; // Date of the event (if applicable)
  final double destinationLatitude; // Latitude of the destination
  final double destinationLongitude; // Longitude of the destination
  final String urlCode;

  NightClubEvent({
    required this.id,
    required this.rating,
    required this.category,
    required this.name,
    required this.imageURL,
    required this.imageURL2,
    required this.imageURL3,
    required this.isFavorited,
    required this.description,
    required this.isSelected,
    required this.comment1,
    required this.comment2,
    required this.dressCode,
    required this.entryFee,
    required this.eventDate,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.urlCode,
  });

  // List of Night Clubs and Events
  static List<NightClubEvent> nightClubList = [

    NightClubEvent(
      id: 1,
      rating: 4.5,
      category: 'Live Concert',
      name: 'Big Willy’s',
      imageURL: 'assets/disco1.jpg',
      imageURL2: 'assets/picicon/gina.jpg',
      imageURL3: 'assets/picicon/dhav.png',
      isFavorited: false,
      description: 'Big Willy’s is the go-to spot for live music, themed parties, and a mix of indoor and outdoor entertainment areas.',
      isSelected: false,
      comment1: 'Big Willy’s never disappoints with its live music performances and vibrant energy.',
      comment2: 'The perfect place for a group night out with good food, music, and vibes.',
      dressCode: 'Smart Casual',
      entryFee: 'MUR 500',
      eventDate: 'Fridays & Saturdays',
      destinationLatitude: -20.3274,
      destinationLongitude: 57.3855,
      urlCode: "Big Willy's",

    ), NightClubEvent(
      id: 0,
      rating: 4.7,
      category: 'Nightclub',
      name: 'Banana Beach Club',
      imageURL: 'assets/disco2.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/bob.jpg',
      isFavorited: false,
      description: 'Banana Beach Club is one of the most iconic nightclubs in Mauritius, offering a vibrant atmosphere, live music, and delicious cocktails.',
      isSelected: false,
      comment1: 'The live band here makes every night unforgettable, and the atmosphere is just perfect for a fun night out.',
      comment2: 'Great drinks, lively crowd, and excellent service — a must-visit spot for nightlife enthusiasts!',
      dressCode: 'Casual',
      entryFee: 'Free Entry',
      eventDate: 'Open Daily',
      destinationLatitude: -20.0100,
      destinationLongitude: 57.5831,
      urlCode: "Banana Beach Club",
    ),
    NightClubEvent(
      id: 2,
      rating: 4.8,
      category: 'Beach Party',
      name: 'C Beach Club',
      imageURL: 'assets/disco3.jpg',
      imageURL2: 'assets/picicon/gina.jpg',
      imageURL3: 'assets/picicon/lim.jpg',
      isFavorited: false,
      description: 'C Beach Club combines beachfront vibes with vibrant parties, DJ nights, and tropical cocktails.',
      isSelected: false,
      comment1: 'Nothing beats dancing on the beach under the stars at C Beach Club.',
      comment2: 'Amazing music, great crowd, and the perfect beach party vibe!',
      dressCode: 'Beachwear',
      entryFee: 'MUR 1,000',
      eventDate: 'Saturdays',
      destinationLatitude: -20.5058,
      destinationLongitude: 57.4079,
      urlCode: "C Beach Club",
    ),
    NightClubEvent(
      id: 3,
      rating: 4.6,
      category: 'Nightclub',
      name: 'Insomnia Nightclub',
      imageURL: 'assets/disco4.jpg',
      imageURL2: 'assets/picicon/gina.jpg',
      imageURL3: 'assets/picicon/lim.jpg',
      isFavorited: false,
      description: 'Insomnia Nightclub is known for its energetic vibe, top DJs, and state-of-the-art sound and lighting systems.',
      isSelected: false,
      comment1: 'Insomnia lives up to its name — you won’t want to leave until sunrise!',
      comment2: 'The music is incredible, and the crowd is always lively and fun.',
      dressCode: 'Formal',
      entryFee: 'MUR 700',
      eventDate: 'Weekends Only',
      destinationLatitude: -20.0065,
      destinationLongitude: 57.5819,
      urlCode: "Insomnia Night Club",
    ),
  ];

  // Get favorited events
  static List<NightClubEvent> getFavoritedEvents() {
    return nightClubList.where((event) => event.isFavorited == true).toList();
  }

  // Get selected events
  static List<NightClubEvent> getSelectedEvents() {
    return nightClubList.where((event) => event.isSelected == true).toList();
  }
}



