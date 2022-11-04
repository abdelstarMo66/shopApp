import 'package:flutter/material.dart';

import '../cubit/cubit.dart';
import '../style/colors/colors.dart';

Widget BuildListProduct(model, context) => Container(
      padding: EdgeInsets.all(12.0),
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model!.image}'),
                height: 120.0,
                width: 120.0,
              ),
              if (model.discount != null)
                if (model.discount != 0)
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
                          "${model.discount}%",
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
            width: 3.0,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 7.0,
                ),
                Text(
                  "${model.name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.price}",
                      style: TextStyle(
                          color: defColor, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    if (model.discount != null)
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice}",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: AppCubit.get(context).favourite![model.id]
                            ? Colors.red[400]
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          AppCubit.get(context)
                              .FavouriteData(ProdcctID: model.id);
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
          ),
        ],
      ),
    );
