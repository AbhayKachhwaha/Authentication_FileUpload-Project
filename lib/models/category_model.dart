import 'package:flutter_assignment/models/subcategory_model.dart';

class Category {
  String id;
  String name;
  List<SubCategory> subcategories;

  Category({
    required this.id,
    required this.name,
    required this.subcategories,
  });

  static List<Category> fetchCategories() {
    List<Category> categories = [
      Category(id: 'identity', name: 'Identity', subcategories: [
        SubCategory('passport', 'Passport'),
        SubCategory('aadhar', 'Aadhar Card')
      ]),
      Category(id: 'residence', name: 'Residence', subcategories: [
        SubCategory('driverslic', 'Drivers License'),
        SubCategory('bill', 'Electricity Bill')
      ]),
      Category(id: 'finance', name: 'Finance', subcategories: [
        SubCategory('paystub', 'Pay Stub'),
        SubCategory('insurance', 'Insurance')
      ]),
    ];
    return categories;
  }
}
