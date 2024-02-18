import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/model/app_calling/tmdb_api.dart';
import 'package:admin_ticead/view/movie/screen/detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUpdateWidget extends StatelessWidget {
  const SearchUpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.find<MovieController>();
    return Obx(() {
      if (cntrl.moviesearchController.text.isEmpty) {
        return Container(
            height: MediaQuery.of(context).size.height * .54,
            child: Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Column(
                children: List.generate(cntrl.allMovies.length, (index) {
                  final value = cntrl.allMovies;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      // onTap: ()=>  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MovieDetailView(selectedMovie:value[index] ,) )),
                      onTap: ()=>  Get.to( ()=>MovieDetailView(selectedMovie:value[index])) ,
                      // cntrl.selectMovie(value);
                      child: Container(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        height: 120,
                        child: Row(
                          children: [
                            Image.network(
                                Constants.iMgurl + value[index].posterpath!),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              value[index].title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: Colors.white),
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )));

     
      } else {
        if ((cntrl.searchListener.isEmpty)) {
          return const Text('NO Data Found');
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * 0.54,
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                child: Column(
                  children: List.generate(cntrl.searchListener.length, (index) {
                    final value = cntrl.searchListener;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                           onTap: ()=>  Get.to( ()=>MovieDetailView(selectedMovie:value[index])) ,
                        child: Container(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          height: 120,
                          child: Row(
                            children: [
                              Image.network(
                                  Constants.iMgurl + value[index].posterpath!),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  value[index].title!,
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
                  }),
                ),
              ),
            ),
          );
        }
      }
    });
  }
}
