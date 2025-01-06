//
// class PlaceOfInterest {
//   final int placeId;
//   final double rating;
//   final String category;
//   final String placeName;
//   final String imageURL;      // First image
//   final String imageURL2;     // Second image
//   final String imageURL3;     // Third image
//   bool isFavorited;
//   final String description;
//   bool isSelected;
//   final String comment1; // Replacing size with comment1
//   final String comment2; // Replacing temperature with comment2
//   final String size;    // Re-added size field
//
//   PlaceOfInterest({
//     required this.placeId,
//     required this.rating,
//     required this.category,
//     required this.placeName,
//     required this.imageURL,
//     required this.imageURL2, // Second image field
//     required this.imageURL3, // Third image field
//     required this.isFavorited,
//     required this.description,
//     required this.isSelected,
//     required this.comment1,  // Replacing size with comment1
//     required this.comment2,  // Replacing temperature with comment2
//     required this.size,      // Re-added size field
//   });
//
//   // List of Places of Interest data_model
//   static List<PlaceOfInterest> placeList = [
//     PlaceOfInterest(
//       placeId: 0,
//       rating: 4.5,
//       category: 'Mountains',
//       placeName: 'Le Morne Brabant',
//       imageURL: 'assets/lemorne1.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'Le Morne Brabant stands as a majestic symbol of natural beauty, its towering cliffs and lush surroundings offering a breathtaking panorama of the southern coast of Mauritius.',
//       isSelected: false,
//       comment1: 'The mountains are a perfect reminder that beauty lies in '
//           'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.', // Replacing size with comment1
//       comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.', // Replacing temperature with comment2
//       size: 'mm', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 1,
//       rating: 4.8,
//       category: 'City',
//       placeName: 'Port Louis',
//       imageURL: 'assets/Port-Louis.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'Port Louis is the capital city of Mauritius, in the Indian Ocean. Its known for its French colonial architecture and the 19th-century Champ de Mars horse-racing track. The Caudan Waterfront is a lively dining and shopping precinct. Nearby, vendors sell local produce and handicrafts at the huge Central Market.',
//       isSelected: false,
//       comment1: 'Port Louis is the vibrant heart of Mauritius, where modernity meets history, offering a fascinating blend of bustling markets, colonial architecture, and a thriving cultural scene.', // Replacing size with comment1
//       comment2: 'Walking through the streets of Port Louis is like stepping into the soul of Mauritius, with its lively atmosphere, colorful markets, and a perfect mix of old-world charm and contemporary energy.', // Replacing tempe
//       size: 'Medium', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 2,
//       rating: 4.7,
//       category: 'Mountain',
//       placeName: 'Eau Blue Waterfall',
//       imageURL: 'assets/waterfall.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'The waterfall originates from the nearby river and comes out on three different levels of the terrain (although the main waterfall is of interest to most of the visitors). All three waterfalls at Eau Bleue are spectacular as you’ll relish on the azure blue color of the pond.',
//       isSelected: false,
//       comment1: 'Nestled in the heart of the island, Eau Bleue Waterfall is a hidden gem, offering visitors a serene escape with its crystal-clear waters and lush surroundings', // Replacing size with comment1
//       comment2: 'The Eau Bleue Waterfall is a picturesque marvel, where the cascading waters create a tranquil oasis, surrounded by vibrant greenery, making it a perfect spot for nature lovers and adventurers alike.', // Replacing tempe
//       size: 'Large', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 3,
//       rating: 4.5,
//       category: 'Mountain',
//       placeName: 'Le Pouce',
//       imageURL: 'assets/hiking.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'The trail begins at a trailhead where Chateau Deau Street ends. Follow the main trail/road. The road will gradually climb and bring you towards Le Pouce.',
//       isSelected: false,
//       comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views of the islands stunning landscapes.', // Replacing size with comment1
//       comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.', // Replacing temperature with comment2
//       size: 'Small', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 4,
//       rating: 4.1,
//       category: 'Historical',
//       placeName: 'Botanical Garden',
//       imageURL: 'assets/garden.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'The Sir Seewoosagur Ramgoolam Botanical Garden is a lush paradise, home to an impressive collection of exotic plants, serene pathways, and picturesque ponds, making it a must-visit for nature lovers.',
//       isSelected: false,
//       comment1: 'A walk through the botanical garden is like stepping into a world of tranquility, with towering palms, vibrant flowers, and the unique Giant Water Lilies offering a peaceful escape from the bustling city life.', // Replacing size with comment1
//       comment2: 'As one of the oldest and most renowned botanical gardens in the Southern Hemisphere, the Sir Seewoosagur Ramgoolam Botanical Garden is a living showcase of Mauritius rich biodiversity and horticultural beauty.', // Replacing temperature with comment2
//       size: 'Large', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 5,
//       rating: 4.4,
//       category: 'Activity',
//       placeName: 'The Aquarium',
//       imageURL: 'assets/aquarium.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'The Mauritius Aquarium offers a fascinating underwater journey, showcasing the vibrant marine life of the Indian Ocean, from colorful tropical fish to majestic sea turtles.',
//       isSelected: false,
//       comment1: 'A visit to the Mauritius Aquarium is a delightful experience for all ages, providing an up-close look at the island’s rich marine biodiversity and the beauty of its coral reefs.', // Replacing size with comment1
//       comment2: 'Discover the wonders of the deep at the Mauritius Aquarium, where visitors can explore a wide variety of marine species in beautifully designed tanks that mimic their natural habitats.', // Replacing temperature with comment2
//       size: 'Medium', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 6,
//       rating: 4.2,
//       category: 'Garden',
//       placeName: 'Vallée des Couleurs',
//       imageURL: 'assets/78.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'The Vallée des Couleurs is not just about its unique geological formation; it offers adventure activities like ziplining and quad biking, making it a perfect destination for thrill-seekers and nature enthusiasts alike.',
//       isSelected: false,
//       comment1: 'he Vallée des Couleurs is a natural wonder, where the earth’s vibrant hues blend beautifully with the lush greenery, creating a mesmerizing landscape like no other.', // Replacing size with comment1
//       comment2: 'The stunning shades of red, brown, violet, green, blue, purple, and yellow at the Vallée des Couleurs are a geological marvel, offering a glimpse into the volcanic history', // Replacing temperature with comment2
//       size: 'Small', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 7,
//       rating: 4.5,
//       category: 'Garden',
//       placeName: 'Crocodile Park',
//       imageURL: 'assets/lavanille.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'La Vanille Nature Park, also known as the Crocodile Park, offers a thrilling experience with its fascinating collection of Nile crocodiles, giant tortoises, and other unique wildlife.',
//       isSelected: false,
//       comment1: 'A visit to the Crocodile Park is both educational and exciting, providing an up-close encounter with these majestic reptiles while exploring the lush tropical setting of the park.', // Replacing size with comment1
//       comment2: 'La Vanille Nature Park is not just about crocodiles; it’s a haven for animal lovers, with a diverse array of species, including monkeys, iguanas, and a butterfly sanctuary.', // Replacing temperature with comment2
//       size: 'Medium', // Re-added size field
//     ),
//     PlaceOfInterest(
//       placeId: 8,
//       rating: 4.7,
//       category: 'Activity',
//       placeName: 'Snorkeling',
//       imageURL: 'assets/snorking.jpg',
//       imageURL2: 'assets/dhav.png', // Second image
//       imageURL3: 'assets/gina.jpg', // Third image
//       isFavorited: false,
//       description: 'Whether youre a beginner or an experienced snorkeler, Mauritius offers something for everyone, from shallow coral gardens to thriving marine ecosystems teeming with exotic species.',
//       isSelected: false,
//       comment1: 'Snorkeling in Mauritius is a magical experience, offering a glimpse into the vibrant underwater world of coral reefs, tropical fish, and crystal-clear lagoons.', // Replacing size with comment1
//       comment2: 'The turquoise waters of Mauritius make it a snorkeling paradise, where you can explore colorful marine life just a few meters below the surface.', // Replacing temperature with comment2
//       size: 'Medium', // Re-added size field
//     ),
//   ];
//
//   // Get the favorited places
//   static List<PlaceOfInterest> getFavoritedPlaces() {
//     List<PlaceOfInterest> placeList = PlaceOfInterest.placeList;
//     return placeList.where((element) => element.isFavorited == true).toList();
//   }
//
//   // Get the selected places
//   static List<PlaceOfInterest> selectedPlaces() {
//     List<PlaceOfInterest> selectedPlaces = PlaceOfInterest.placeList;
//     return selectedPlaces.where((element) => element.isSelected == true).toList();
//   }
// }
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
  final String openingHours; // Opening hours (if applicable)

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
  });

  // List of Places of Interest
  static List<PlaceOfInterest> placeList = [
    PlaceOfInterest(
      id: 0,
      rating: 4.5,
      name: 'gateau-piment.',
      imageURL: 'assets/images/food2.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Le Morne Brabant stands as a majestic symbol of natural beauty, its towering cliffs and lush surroundings offering a breathtaking panorama of the southern coast of Mauritius.',
      isSelected: false,
      entryFee: 'Free',  // Example, can change based on the actual entry fee
      comment1: 'The mountains are a perfect reminder that beauty lies in simplicity — their timeless peaks stand as silent witnesses to nature’s most serene moments.',
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to nature’s most serene beauty.',
      openingHours: 'Daily, 8:00 AM - 5:00 PM',
    ),
    PlaceOfInterest(
      id: 1,
      rating: 4.8,
      name: 'Henna',
      imageURL: 'assets/images/Henna.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/bob.jpg',
      isFavorited: false,
      description: 'Port Louis is the capital city of Mauritius, known for its French colonial architecture and the 19th-century Champ de Mars horse-racing track.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Port Louis is the vibrant heart of Mauritius, where modernity meets history, offering a fascinating blend of bustling markets, colonial architecture, and a thriving cultural scene.',
      comment2: 'Walking through the streets of Port Louis is like stepping into the soul of Mauritius, with its lively atmosphere, colorful markets, and a perfect mix of old-world charm and contemporary energy.',
      openingHours: 'Mon-Sat, 9:00 AM - 6:00 PM',
    ),
    PlaceOfInterest(
      id: 2,
      rating: 4.7,
      name: 'Gato-de-lhuile',
      imageURL: 'assets/images/food3.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'The Eau Blue Waterfall offers stunning views with its azure blue ponds, surrounded by lush greenery and multiple levels of cascading water.',
      isSelected: false,
      entryFee: 'MUR 100',
      comment1: 'Nestled in the heart of the island, Eau Bleue Waterfall is a hidden gem, offering visitors a serene escape with its crystal-clear waters and lush surroundings.',
      comment2: 'The Eau Bleue Waterfall is a picturesque marvel, where the cascading waters create a tranquil oasis, surrounded by vibrant greenery.',
      openingHours: 'Daily, 7:00 AM - 5:00 PM',
    ),
    PlaceOfInterest(
      id: 3,
      rating: 4.5,
      name: 'Tamil Temple',
      imageURL: 'assets/spa.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Le Pouce is one of the highest mountains in Mauritius, offering stunning views of the island.',
      isSelected: false,
      entryFee: 'Free',
      comment1: 'Mountain hiking in Mauritius offers an exhilarating experience, with trails that wind through lush forests, rocky terrains, and panoramic views.',
      comment2: 'Mauritius is a hiker’s paradise, where the rugged mountains challenge adventurers and reward them with breathtaking views of crystal-clear waters and verdant valleys.',
      openingHours: 'All-day access, best before sunset',
    ),
    PlaceOfInterest(
      id: 4,
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
