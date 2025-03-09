class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final int estimatedTime;
  final int quantity;

  // Constructor
  Service({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.category = '',
    this.imageUrl = '',
    this.estimatedTime = 24,
    this.quantity = 1,
  });

  // Factory constructor to create a Service object from a map (JSON/Firestore Document)
  factory Service.fromJson(Map<String, dynamic> json, String id) {
    return Service(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(), // Ensure price is a double
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      estimatedTime:
          (json['estimatedTime'] ?? 24) is int
              ? json['estimatedTime']
              : 24, // Ensure it's an integer
      quantity:
          (json['quantity'] ?? 1) is int
              ? json['quantity']
              : 1, // Ensure it's an integer
    );
  }

  // Method to convert a Service object to a map (for Firestore or JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'estimatedTime': estimatedTime,
      'quantity': quantity, // Added the quantity field here
    };
  }

  factory Service.fromMap(Map<String, dynamic> map, String id) {
    return Service(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      estimatedTime:
          (map['estimatedTime'] ?? 24) is int ? map['estimatedTime'] : 24,
      quantity: (map['quantity'] ?? 1) is int ? map['quantity'] : 1,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'estimatedTime': estimatedTime,
      'quantity': quantity,
    };
  }

  // Copy method to create a new Service object with some updated fields
  Service copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    int? estimatedTime,
    int? quantity,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      quantity: quantity ?? this.quantity,
    );
  }
}
