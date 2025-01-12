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
            print('Reconstruyendo BlocBuilder con estado: $state');
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsStateWithSelected) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: NewsSlider(
                        news: state.articles,
                        onAdd: (article) => context.read<NewsCubit>().addToSelected(article),
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: state.selectedArticles.isNotEmpty
                        ? NewsSlider(news: state.selectedArticles)
                        : const Center(child: Text('No hay noticias seleccionadas.')),
                  ),
                ],
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