import 'package:bloc_pizza_project/bloc/pizza_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pizza_model.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
        BlocProvider(
          create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(title: 'Flutter Bloc Demo'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var random = Random();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return const CircularProgressIndicator(color: Colors.orange);
            }
            if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.pizzas.length}',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          for (int index = 0;
                              index < state.pizzas.length;
                              index++)
                            Positioned(
                              left: random.nextInt(250).toDouble(),
                              top: random.nextInt(400).toDouble(),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: state.pizzas[index].image,
                              ),
                            )
                        ]),
                  )
                ],
              );
            } else {
              return const Text("Something is not right");
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizza[0]));
            },
            child: const Icon(Icons.local_pizza_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[800],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizza[0]));
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[500],
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizza[1]));
            },
            child: const Icon(Icons.local_pizza),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange[500],
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizza[1]));
            },
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
