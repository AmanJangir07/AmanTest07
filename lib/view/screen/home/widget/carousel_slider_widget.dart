import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/provider/home_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _activeIndex = 0;
  bool isLoading = false;
  void getImageSlider() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<HomeProvider>(context, listen: false).getImageSlider();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getImageSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<HomeProvider>(
      builder: (context, home, child) => isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : home.slider!.slider!.length > 0
              ? Column(
                  children: [
                    CarouselSlider.builder(
                        itemCount: home.slider!.slider!.length,
                        itemBuilder: (context, index, realIndex) {
                          final url =
                              home.slider!.slider![index].image!.imageUrl!;
                          return Container(
                              width: double.infinity,
                              child: Image.network(
                                url,
                                fit: BoxFit.fill,
                              ));
                        },
                        options: CarouselOptions(
                            height: 180,
                            autoPlay: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() => _activeIndex = index);
                            },
                            autoPlayAnimationDuration: Duration(seconds: 1))),
                    SizedBox(
                      height: 32,
                      child: AnimatedSmoothIndicator(
                        activeIndex: _activeIndex,
                        count: home.slider!.slider!.length,
                        effect: JumpingDotEffect(dotHeight: 8, dotWidth: 8),
                      ),
                    )
                  ],
                )
              : Text("We will Provide some offers shortly!!! "),
    ));
  }
}
