import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final Image image;

  const Pizza({required this.id, required this.name, required this.image});

  @override
  List<Object?> get props => throw UnimplementedError();

  static List<Pizza> pizza = [
    Pizza(
      id: '0',
      name: 'Pizza',
      image: Image.asset('images/pizza.jpg'),
    ),
    Pizza(
        id: '1',
        name: 'Pizza Cheese',
        image: Image.asset('images/imagePizza.jpg'))
  ];
}
