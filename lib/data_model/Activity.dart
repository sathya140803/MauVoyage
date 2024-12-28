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
    required this.comment1,  // Replacing size with comment1
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
      imageURL: 'assets/scubadive1.jpg',
      imageURL2: 'assets/scubadive2.jpg',
      imageURL3: 'assets/scubadive3.jpg',
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.', // Replacing size with comment1
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.', // Replacing temperature with
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
      imageURL: 'assets/zipline1.jpg',
      imageURL2: 'assets/zipline2.jpg',
      imageURL3: 'assets/zipline3.jpg',
      isFavorited: false,
      description: 'Soar through the treetops and enjoy breathtaking views on our zip-lining adventure.',
      isSelected: false,
      duration: '1 hour',
      comment1: 'The mountains are a perfect reminder that beauty lies in '
          'simplicity — their timeless peaks stand as silent witnesses to natures most serene moments.', // Replacing size with comment1
      comment2: 'The climb up Le Morne Brabant reveals more than just a magnificent landscape; it tells the story of Mauritius past while offering an unforgettable connection to natures most serene beauty.', // Replacing temperature with
      price: 'MUR 1,500',
      location: 'Ebene Forest',
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
