import 'package:flutter/material.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/utils/colortheme.dart';

class ProductsGrid extends StatelessWidget {
  final List list;
  ProductsGrid(this.list);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 5 / 7,
      padding: EdgeInsets.only(top: 12),
      crossAxisCount: 2,
      crossAxisSpacing: 40,
      mainAxisSpacing: 30,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        list.length,
        (index) {
          return ProductBox();
        },
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(1),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=715&q=80https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=715&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Adapen Gel',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(
            height: 2,
            color: ColorTheme.fontBlack,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text('${AppConfig.rs} 30'),
          ),
        ],
      ),
    );
  }
}
