part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();
  
  @override
  List<Object> get props => [];
}

class PizzaInitial extends PizzaState {}
