import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:admin_ticead/view/movie/screen/detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UpdatingWidget extends StatelessWidget {
  const UpdatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.find<MovieController>();
    return StreamBuilder<List<MovieModel>>(
      stream: cntrl.moviesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset('asset/lottie/Animation - 1708104826864.json');
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('NO Data Found');
        }

        // List<MovieModel> movies = snapshot.data!;

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () => Get.to(() =>
                    MovieDetailView(selectedMovie: snapshot.data![index])),
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  height: 120,
                  child: Row(
                    children: [
                      // snapshot.data?[index].poster != null
                      //           ?
                      Image.network(
                        snapshot.data![index].poster,
                        errorBuilder: (context, error, stackTrace) {
                           return Lottie.asset('asset/lottie/image_loading.json');
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Lottie.asset(
                                'asset/lottie/Animation - 1708104826864.json');
                          }
                        },
                      ),
                      // : Lottie.asset('asset/lottie/Animation - 1708104826864.json'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          snapshot.data![index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
