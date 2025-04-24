import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

final class CategoryViewerMobile extends StatelessWidget {
  const CategoryViewerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'.tr()),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemBuilder: (_, counter) {
          return Placeholder();
        },
        itemCount: 0,
      ),
    );
  }
}
