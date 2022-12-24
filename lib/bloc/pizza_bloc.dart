import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/pizza_model.dart';
part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    //when we start the application, this will be first event
    on<LoadPizzaCounter>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const PizzaLoaded(
          pizzas: <Pizza>[])); //after waiting one sec, emit PizzaLoaded
    });

    on<AddPizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        emit(
          PizzaLoaded(
            pizzas: List.from(state.pizzas)..add(event.pizza),
          ),
        );
      }
    });

    on<RemovePizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        emit(
          PizzaLoaded(
            pizzas: List.from(state.pizzas)..remove(event.pizza),
          ),
        );
      }
    });
  }
}
