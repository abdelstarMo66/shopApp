import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';
import 'package:shop_app/sheared/cubit/states.dart';

import '../models/categories_model.dart';
import '../sheared/style/colors/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ConditionalBuilder(
              condition: cubit.homeModel != null,
              builder: (context) => ProductBuilder(
                  cubit.homeModel!, cubit.CategoryModel!, context),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget ProductBuilder(HomeModel model, CategoriesModel catModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 7),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.easeInQuint,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Categories',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    categoryBuild(catModel.data!.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                  width: 20.0,
                ),
                itemCount: catModel.data!.data.length,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Products',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              color: Colors.black26,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                  model.data!.products.length,
                  (index) => GridBuilderProdect(
                      index, model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget GridBuilderProdect(index, productData modeldata, context) {
    return Container(
      color: AppCubit.get(context).DarkMade ? Color(0xFF292A2F) : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${modeldata.image}'),
                height: 200,
                width: double.infinity,
              ),
              if (modeldata.discount != 0)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${modeldata.discount}%",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.local_offer_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${modeldata.name}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            children: [
              Text(
                "${modeldata.price}",
                style: TextStyle(color: defColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 3.0,
              ),
              if (modeldata.discount != 0)
                Text(
                  "${modeldata.oldPrice}",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).favourite![modeldata.id]
                      ? Colors.red[400]
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppCubit.get(context)
                        .FavouriteData(ProdcctID: modeldata.id);
                  },
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryBuild(DataModelCat modelcategory) => ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${modelcategory.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Container(
                width: 100,
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  '${modelcategory.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      );
}
