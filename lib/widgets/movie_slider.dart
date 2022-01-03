import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> popularMovies;
  final String? title;

  const MovieSlider({Key? key, required this.popularMovies, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: si no hay titulo, no debe aparecer este widget
          title != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          SizedBox(
            height: 3,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularMovies.length,
                itemBuilder: (_, int index) =>
                    _MoviePoster(movie: popularMovies[index])),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({Key? key, required this.movie}) : super(key: key);
  //TODO

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 190,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: 'movie-arg'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage("assets/no-image.jpg"),
                    image: NetworkImage(movie.fullPosterImg),
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
