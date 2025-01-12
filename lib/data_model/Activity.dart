class Activity {
  final int id;
  final double rating;
  final String name;
  final String imageURL; // Main image
  final String imageURL2; // Secondary image
  final String imageURL3; // Tertiary image
  bool isFavorited;
  final String comment1; // Replacing size with comment1
  final String comment2;
  final String description;
  bool isSelected;
  final String duration; // Duration of the activity
  final String price; // Price of the activity
  final String location; // Location of the activity

  Activity({
    required this.id,
    required this.rating,
    required this.name,
    required this.imageURL,
    required this.imageURL2,
    required this.imageURL3,
    required this.isFavorited,
    required this.comment1,
    required this.comment2,
    required this.description,
    required this.isSelected,
    required this.duration,
    required this.price,
    required this.location,
  });

  // List of Activities
  static List<Activity> activityList = [
    Activity(
      id: 0,
      rating: 4.7,
      name: 'Scuba Diving',
      imageURL: 'assets/activities/1b.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/bob.jpg',
      comment1: 'Discover vibrant marine life and coral reefs.',
      comment2: 'Dive deep to explore the wonders of the ocean.',
      isFavorited: false,
      description: 'Explore the vibrant underwater world with our guided scuba diving tours.',
      isSelected: false,
      duration: '2 hours',
      price: 'MUR 2,000',
      location: 'Grand Baie',
    ),
    Activity(
      id: 1,
      rating: 4.8,
      name: 'Zip-lining',
      imageURL: 'assets/activities/zip.jpg',
      imageURL2: 'assets/picicon/lim.jpg',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Soar through the treetops and enjoy breathtaking views on our zip-lining adventure.',
      isSelected: false,
      duration: '1 hour',
      comment1: 'Feel the thrill of flying through the trees.',
      comment2: 'Perfect for adventure lovers.',
      price: 'MUR 1,500',
      location: 'Ebene Forest',
    ),
    Activity(
      id: 2,
      rating: 4.9,
      name: 'Catamaran Cruise',
      imageURL: 'assets/activities/catamaron.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/lim.jpg',
      isFavorited: false,
      description: 'Relax on a luxurious catamaran and enjoy the crystal-clear waters.',
      isSelected: false,
      duration: '4 hours',
      comment1: 'Sail to hidden lagoons and enjoy stunning views.',
      comment2: 'Includes lunch and snorkeling.',
      price: 'MUR 3,500',
      location: 'Black River',
    ),
    Activity(
      id: 3,
      rating: 4.6,
      name: 'Hiking at Le Morne',
      imageURL: 'assets/activities/hik.jpg',
      imageURL2: 'assets/picicon/bob.jpg',
      imageURL3: 'assets/picicon/dhav.png',
      isFavorited: false,
      description: 'Take an exhilarating hike up Le Morne Mountain and enjoy panoramic views.',
      isSelected: false,
      duration: '3 hours',
      comment1: 'A UNESCO World Heritage Site with a breathtaking history.',
      comment2: 'Perfect for nature and fitness enthusiasts.',
      price: 'MUR 1,200',
      location: 'Le Morne Brabant',
    ),
    Activity(
      id: 4,
      rating: 4.5,
      name: 'Quad Biking Adventure',
      imageURL: 'assets/activities/quad.jpg',
      imageURL2: 'assets/picicon/dhav.png',
      imageURL3: 'assets/picicon/gina.jpg',
      isFavorited: false,
      description: 'Experience the thrill of exploring off-road tracks on a quad bike.',
      isSelected: false,
      duration: '2 hours',
      comment1: 'Adrenaline-pumping adventure for thrill-seekers.',
      comment2: 'Explore scenic trails and wildlife.',
      price: 'MUR 2,500',
      location: 'Bel Ombre',
    ),
    Activity(
      id: 5,
      rating: 4.7,
      name: 'Swimming with Dolphins',
      imageURL: 'assets/activities/swim.jpg',
      imageURL2: 'assets/picicon/bob.jpg',
      imageURL3: 'assets/picicon/dhav.png',
      isFavorited: false,
      description: 'Get up close and personal with dolphins in their natural habitat.',
      isSelected: false,
      duration: '1.5 hours',
      comment1: 'A magical experience with these intelligent creatures.',
      comment2: 'An unforgettable memory for animal lovers.',
      price: 'MUR 3,000',
      location: 'Tamarin Bay',
    ),
  ];

  // Get favorited activities
  static List<Activity> getFavoritedActivities() {
    return activityList.where((activity) => activity.isFavorited == true).toList();
  }

  // Get selected activities
  static List<Activity> getSelectedActivities() {
    return activityList.where((activity) => activity.isSelected == true).toList();
  }
}
