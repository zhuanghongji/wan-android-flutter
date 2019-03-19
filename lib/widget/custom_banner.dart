import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../api/datas/banner.dart';

class RefreshSafeArea extends StatelessWidget {
  final Widget child;

  RefreshSafeArea({ 
    Key key, 
    this.child 
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        return true;
      },
      child: this.child,
    );
  }
}

/// 轮播图部件
class CustomBanner extends StatelessWidget {
  final List<BannerItem> bannerItems;
  final void Function(int index) onTap;

  CustomBanner(this.bannerItems, this.onTap);

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        this.onTap(index);
      },
      child: Container(
        child: Image.network(
          bannerItems[index].imagePath, 
          fit:BoxFit.fill
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshSafeArea(
      child: Swiper(
        itemHeight: 100,
        itemCount: bannerItems.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          var bannerItem = bannerItems[index];
          if (bannerItem == null || bannerItem.imagePath == null) {
            return Container(
              color: Colors.grey[100],
            );
          } else {
            return buildItem(context, index);
          }
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}