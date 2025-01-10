import 'package:cubik_app/providers/newscubit.dart';
import 'package:cubik_app/providers/newsstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/news_slider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Home'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => NewsCubit()..fetchNews(),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              // Usamos el widget NewsSlider para mostrar la lista de noticias
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: NewsSlider(news: state.articles),
              );
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Sin noticias disponibles'));
          },
        ),
      ),
    );
  }
}