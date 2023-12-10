import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HotelsEntity extends Equatable {
  HotelsEntity({
    this.address,
    this.description,
    this.image,
    this.id,
    this.name,
    this.price,
    this.rating,
    this.stars,
  });

  final String? address;
  final String? description;
  final int? id;
  final String? image;
  final String? name;
  final Map<String, dynamic>? price;
  final double? rating;
  final int? stars;

  String get getPrice {
    double value = price!['value'].runtimeType == double
        ? price!['value']
        : price!['value'] + 0.00000001;
    return '${price!['currency']} ${value.toStringAsFixed(2)}';
  }

  HotelsEntity copyWith(HotelsEntity mod) {
    return HotelsEntity(
      address: mod.address ?? address,
      description: mod.description ?? description,
      image: mod.image ?? image,
      id: mod.id ?? id,
      name: mod.name ?? name,
      price: mod.price ?? price,
      rating: mod.rating ?? rating,
      stars: mod.stars ?? stars,
    );
  }

   factory HotelsEntity.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return HotelsEntity(
      // id: snapshot.id,
      address: snapshot['address'],
      description: snapshot['description'],
      id: snapshot['id'],
      image: snapshot['image'],
      name: snapshot['name'],
      rating: snapshot['rating'].runtimeType is double
          ? snapshot['rating']
          : snapshot['rating'].toDouble(),
      price: snapshot['price'],
      stars: snapshot['stars'],
    );
  }

  @override
  List<Object?> get props => [
        address,
        description,
        image,
        id,
        name,
        price,
        rating,
        stars,
      ];
}
