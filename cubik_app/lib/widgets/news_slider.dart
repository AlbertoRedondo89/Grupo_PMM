import 'package:cubik_app/models/article.dart';
import 'package:flutter/material.dart';

class NewsSlider extends StatelessWidget {
  final List<Article> news;
  final Function(Article)? onAdd; // Función para añadir noticias

  const NewsSlider({Key? key, required this.news, this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (news.isEmpty) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Noticias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: news.length,
              itemBuilder: (_, int index) => _NewImage(
                artic: news[index],
                onAdd: onAdd,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NewImage extends StatelessWidget {
  final Article artic;
  final Function(Article)? onAdd; // Función para añadir noticias

  const _NewImage({Key? key, required this.artic, this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: artic.urlToImage != null && artic.urlToImage!.isNotEmpty
                    ? NetworkImage(artic.urlToImage!)
                    : const AssetImage('assets/no-image.jpg') as ImageProvider,
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              artic.title.isNotEmpty ? artic.title : 'Sin título',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (onAdd != null)
            ElevatedButton(
              onPressed: () => onAdd!(artic),
              child: const Text('Añadir'),
            ),
        ],
      ),
    );
  }
}
