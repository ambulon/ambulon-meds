import 'package:flutter/material.dart';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/views/search/search_result_page.dart';

class ProductsGrid extends StatelessWidget {
  final List<MedicineModel> list;
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
          return ProductBox(model: list[index]);
        },
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final MedicineModel model;
  ProductBox({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => SearchResult(str: model.name, preset: true)));
      },
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
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              model.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(
            height: 2,
            color: ColorTheme.fontBlack,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text('${AppConfig.rs} ${model.bestBuyPrice.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }
}
