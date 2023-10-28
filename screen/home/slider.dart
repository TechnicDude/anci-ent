import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/model/bannerlistModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SliderScreen extends StatelessWidget {
  final List<BannerData>? bannerdata;
  const SliderScreen({Key? key, this.bannerdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: bannerdata!.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return InkWell(
          onTap: () {},
          child: CachedNetworkImage(
              imageUrl: APIURL.imageurl + bannerdata![itemIndex].image!,
              width: 100.w,
              fit: BoxFit.cover),
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: false,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
    );
  }
}
