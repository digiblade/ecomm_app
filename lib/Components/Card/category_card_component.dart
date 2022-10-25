import 'package:ecommerce/Util/consturl.dart';
import 'package:flutter/material.dart';

class CategoryCardComponent extends StatefulWidget {
  String? category;
  String? image;
  CategoryCardComponent({Key? key, this.category, this.image})
      : super(key: key);

  @override
  State<CategoryCardComponent> createState() => _CategoryCardComponentState();
}

class _CategoryCardComponentState extends State<CategoryCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.2,
        ),
        width: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: widget.image != ""
                  ? Image.network(
                      widget.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/images/dragonfruit.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.category!,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
