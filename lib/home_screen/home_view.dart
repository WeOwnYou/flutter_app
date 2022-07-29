import 'package:flutter/material.dart';
import 'package:flutter_app/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          child: Builder(
            builder: (context) {
              final provider =
                  Provider.of<HomeViewModel>(context, listen: false);
              final milliseconds = provider.isDragging ? 0 : 400;
              final position = provider.position;
              return AnimatedContainer(
                duration: Duration(milliseconds: milliseconds),
                transform: Matrix4.identity()
                  ..translate(position.dx, position.dy),
                child: buildClipRRect(),
              );
            },
          ),
          onPanStart: (details) {
            final provider = Provider.of<HomeViewModel>(context, listen: false);

            provider.startPosition(details);
          },
          onPanUpdate: (details) {
            final provider = Provider.of<HomeViewModel>(context, listen: false);

            provider.updatePosition(details);
          },
          onPanEnd: (details) {
            final provider = Provider.of<HomeViewModel>(context, listen: false);

            provider.endPosition();
          },
        ),
      ),
    );
  }

  ClipRRect buildClipRRect() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: NetworkImage(
                'https://miro.medium.com/max/1200/1*ul46xGjg18pYRL9BufPn_w.png'),
          ),
        ),
        // fit: BoxFit.cover,
        // image: ResizeImage(
        //   Image.network(
        //           'https://miro.medium.com/max/1200/1*ul46xGjg18pYRL9BufPn_w.png')
        //       .image,
        //   height: height.toInt(),
        //   width: width.toInt(),
        // )),
      ),
    );
  }
}
