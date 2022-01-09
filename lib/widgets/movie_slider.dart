import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {Key? key, required this.movies, required this.onNextPage, this.title})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: si no hay titulo, no debe aparecer este widget
          widget.title != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          SizedBox(
            height: 3,
          ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) =>
                    _MoviePoster(movie: widget.movies[index])),
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
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: movie),
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
