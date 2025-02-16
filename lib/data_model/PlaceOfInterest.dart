
class PlaceOfInterest {
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
  final String entryFee; // Entry fee or ticket price (if applicable)
  final String openingHours;
  final double destinationLatitude; // Latitude of the destination
  final double destinationLongitude; // Longitude of the destination// Opening hours (if applicable)
  final String urlCode;

  PlaceOfInterest({
    required this.id,
    required this.rating,
    required this.name,
    required this.imageURL,
    required this.imageURL2,
    required this.imageURL3,
    required this.comment1,  // Replacing size with comment1
    required this.comment2,
    required this.isFavorited,
    required this.description,
    required this.isSelected,
    required this.entryFee,
    required this.openingHours,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.urlCode,
  });

  // List of Places of Interest
  static List<PlaceOfInterest> placeList = [
    PlaceOfInterest(
      id: 0,
      rating: 4.5,
      name: 'Gateau-Piment',
      imageURL: 'assets/images/food2.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Gateau-Piment, also known as "chili cake," is a popular Mauritian snack made from yellow split peas (or lentils), spices, and chili. The ingredients are ground into a paste, shaped into small cakes, and deep-fried until crispy.',
      isSelected: false,
      entryFee: 'Free',  // Example, can change based on the actual entry fee
      comment1: 'The perfect blend of spices and crispy texture, Gateau-Piment is a must-try for anyone visiting Mauritius!',
      comment2: 'A delicious street food snack that packs a punch of flavor in every bite.',
      openingHours: 'Daily, 8:00 AM - 5:00 PM',
      destinationLatitude: -20.2455504,
      destinationLongitude: 57.4511704,
      urlCode: "Chez Dowlut",
    ),
    PlaceOfInterest(
      id: 1,
      rating: 4.8,
      name: 'Henna',
      imageURL: 'assets/images/Henna.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/bob.jpg',
      isFavorited: false,
      description: 'Henna is a natural dye made from the leaves of the henna plant (Lawsonia inermis). It is commonly used to create intricate designs on the skin, particularly on the hands and feet, as part of traditional beauty.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Henna art is not just a beauty tradition; its a symbol of celebration and cultural expression',
      comment2: 'The intricate designs are always mesmerizing, and the process feels like a form of meditation.',
      openingHours: 'Mon-Sat, 9:00 AM - 6:00 PM',
      destinationLatitude: -20.242601,
      destinationLongitude: 57.4735627,
      urlCode: "Tattoo Art Lovers Mauritius",
    ),

    PlaceOfInterest(
      id: 3,
      rating: 4.5,
      name: 'Tamil Temple',
      imageURL: 'assets/temple.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Tamil temples in Mauritius are places of worship for the Tamil Hindu community. These temples are known for their intricate architecture, vibrant colors, and cultural significance.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'The Tamil temples in Mauritius are not just places of worship but cultural landmarks that showcase the islands diverse heritage.',
      comment2: 'Visiting a Tamil temple offers a peaceful experience where tradition and spirituality come together beautifully.',
      openingHours: 'All-day access, best before sunset',
      destinationLatitude: -20.2241018,
      destinationLongitude: 57.4678516,
      urlCode: "Mauritius Tamil Temples Federation, மொரிஷியஸ் தமிழ் கோவில்கள் கூட்டமைப்பு",
    ),

    PlaceOfInterest(
      id: 4,
      rating: 4.1,
      name: 'Botanical Garden',
      imageURL: 'assets/garden.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'The Sir Seewoosagur Ramgoolam Botanical Garden is a lush paradise, home to an impressive collection of exotic plants, serene pathways, and picturesque ponds, making it a must-visit for nature lovers.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: 'All-day access, best before sunset',
      destinationLatitude: -20.1047,
      destinationLongitude: 57.5803,
      urlCode: "Sir Seewoosagur Ramgoolam Botanical Garden",
    ),

    PlaceOfInterest(
      id: 5,
      rating: 4.7,
      name: 'Gato-de-lhuile',
      imageURL: 'assets/images/food3.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Gato-de-lhuile, or "oil cake," is a traditional Mauritian pastry made by deep-frying dough balls until golden brown and crispy.',
      isSelected: false,
      entryFee: 'MUR 100',
      comment1: 'Crispy, golden, and irresistibly delicious—Gato-de-lhuile brings the taste of Mauritius right to your fingertips.',
      comment2: 'A sweet or savory indulgence, depending on your taste—either way, Gato-de-lhuile never disappoints.',
      openingHours: 'Daily, 7:00 AM - 5:00 PM',
      destinationLatitude: -20.2547688,
      destinationLongitude: 57.4401593,
      urlCode: "Maraz-Chanapuri-gateaude l'huile",
    ),


    PlaceOfInterest(
      id: 6,
      rating: 4.8,
      name: 'Vallée des Couleurs',
      imageURL: 'assets/78.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'The Vallée des Couleurs is not just about its unique geological formation; it offers adventure activities like ziplining and quad biking, making it a perfect destination for thrill-seekers and nature enthusiasts alike.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: 'All-day access, best before sunset',
      destinationLatitude: -20.4576,
      destinationLongitude: 57.4852,
      urlCode: "La Vallée Des Couleurs Nature Park",
    ),

    PlaceOfInterest(
      id: 7,
      rating: 4.5,
      name: 'Crocodile Park',
      imageURL: 'assets/crocodile.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'La Vanille Nature Park, also known as the Crocodile Park, offers a thrilling experience with its fascinating collection of Nile crocodiles, giant tortoises, and other unique wildlife.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: 'All-day access, best before sunset',
      destinationLatitude: -20.4995,
      destinationLongitude: 57.5633,
      urlCode: "La Vanille Nature Park",
    ),

    PlaceOfInterest(
      id: 8,
      rating: 4.4,
      name: 'Odysseo Aquarium',
      imageURL: 'assets/aquarium.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'The Mauritius Aquarium offers a fascinating underwater journey, showcasing the vibrant marine life of the Indian Ocean, from colorful tropical fish to majestic sea turtles.',
      isSelected: false,
      entryFee: 'MUR 1280',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: '9am - 5pm',
      destinationLatitude: -20.1593,
      destinationLongitude: 57.4951,
      urlCode: "Odysseo-oceanarium (Mauritius) LTD",
    ),

    PlaceOfInterest(
      id: 9,
      rating: 4.7,
      name: 'Eau Bleu Waterfall',
      imageURL: 'assets/waterfall.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'The waterfall originates from the nearby river and comes out on three different levels of the terrain (although the main waterfall is of interest to most of the visitors). All three waterfalls at Eau Bleue are spectacular as you’ll relish on the azure blue color of the pond.',
      isSelected: false,
      entryFee: 'MUR 1280',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: '9am - 5pm',
      destinationLatitude: -20.3699,
      destinationLongitude: 57.6185,
      urlCode: "Cascade Eau Bleu",
    ),

    PlaceOfInterest(
      id: 10,
      rating: 4.5,
      name: 'Le Pouce',
      imageURL: 'assets/hiking.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Le Pouce is one of the highest mountains in Mauritius, offering stunning views of the island.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: 'All-day access, best before sunset',
      destinationLatitude: -20.1950,
      destinationLongitude: 57.5222,
      urlCode: "Le Pouce",
    ),

  ];

  // Get favorited places
  static List<PlaceOfInterest> getFavoritedPlaces() {
    return placeList.where((place) => place.isFavorited == true).toList();
  }

  // Get selected places
  static List<PlaceOfInterest> getSelectedPlaces() {
    return placeList.where((place) => place.isSelected == true).toList();
  }
}
