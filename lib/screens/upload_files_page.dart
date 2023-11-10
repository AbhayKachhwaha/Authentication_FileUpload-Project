// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/upload_data_model.dart';

import '../models/category_model.dart';
import '../models/subcategory_model.dart';
import '../utilities/validator.dart';

class UploadFilesPage extends StatefulWidget {
  const UploadFilesPage({super.key});

  @override
  State<UploadFilesPage> createState() => _UploadFilesPageState();
}

class _UploadFilesPageState extends State<UploadFilesPage> {
  String? selectedCategory;
  String? selectedSubCategory;
  List<Category> categories = [];
  List<UploadData> uploaded = [];
  bool isLoading = true;
  final _descriptionController = TextEditingController();
  Future<String?>? file;

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  Future<void> getCategories() async {
    List<Category> categoriesState = Category.fetchCategories();

    setState(() {
      categories = categoriesState;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var formKey = GlobalKey<FormState>();
    var sizedBox = SizedBox(
      height: screenHeight * 0.05,
    );

    final categoryInputField = Container(
      constraints: BoxConstraints(
        maxWidth: 500,
        minWidth: 150,
      ),
      width: screenWidth * 0.2,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: DropdownButton(
          isExpanded: true,
          value: selectedCategory,
          items: categories
              .map((category) => buildCategoryItem(item: category))
              .toList(),
          onChanged: (value) => onCategoryChange(value.toString()),
        ),
      ),
    );

    final subCategoryInputField = Container(
      constraints: BoxConstraints(
        maxWidth: 500,
        minWidth: 150,
      ),
      width: screenWidth * 0.2,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedSubCategory,
          items: selectedCategory != null
              ? categories
                  .where((category) => category.id == selectedCategory)
                  .elementAt(0)
                  .subcategories
                  .map((e) => buildSubCategoryItem(item: e))
                  .toList()
              : [],
          onChanged: (value) => setState(() => selectedSubCategory = value),
        ),
      ),
    );

    final descriptionField = Container(
      constraints: BoxConstraints(
        minWidth: 100,
      ),
      width: screenWidth * 0.2,
      child: TextFormField(
        controller: _descriptionController,
        validator: (value) => Validator.validateDescription(value),
        maxLines: 5,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: OverflowBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: screenHeight,
                maxWidth: 950,
              ),
              color: Colors.white,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Documents',
                      style: TextStyle(
                        height: screenHeight * 0.008,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Select Category'),
                        FittedBox(
                            fit: BoxFit.fitWidth, child: categoryInputField),
                      ],
                    ),
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Select Sub Category'),
                        subCategoryInputField,
                      ],
                    ),
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Description'),
                        descriptionField,
                      ],
                    ),
                    sizedBox,
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            file = pickFile();
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.1,
                          constraints: BoxConstraints(
                            minWidth: 100,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          height: screenHeight * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                color: Colors.black,
                              ),
                              Center(
                                  child: Text(
                                'Browse to Upload Files',
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedBox,
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ))),
                      onPressed: () {
                        upload(
                          selectedCategory,
                          selectedSubCategory,
                          _descriptionController.text.toString().trim(),
                          file,
                        );
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: screenHeight,
                maxWidth: 950,
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your Uploaded files',
                    style: TextStyle(
                      height: screenHeight * 0.008,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Sub Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    shrinkWrap: true,
                    itemCount: uploaded.length,
                    itemBuilder: ((context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              uploaded[index].categoryName!,
                              style: TextStyle(
                                height: screenHeight * 0.001,
                              ),
                            )),
                            Center(
                                child: Text(uploaded[index].subCategoryName!)),
                            Center(child: Text(uploaded[index].description!)),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildCategoryItem({required Category item}) {
    return DropdownMenuItem(
      value: item.id,
      child: Text(
        item.name,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  DropdownMenuItem<String> buildSubCategoryItem({required SubCategory item}) {
    return DropdownMenuItem(
      value: item.id,
      child: Text(
        item.name,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  void onCategoryChange(String? value) {
    if (value != selectedCategory) {
      setState(
        () => selectedCategory = value,
      );
      setState(() => selectedSubCategory = null);
    }
  }

  Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.first.name;
    }
    return null;
  }

  void upload(
    String? category,
    String? subCategory,
    String? description,
    fileName,
  ) {
    if (category != null && subCategory != null && fileName != null) {
      setState(() {
        uploaded = [
          ...uploaded,
          UploadData(
            categoryName: category,
            subCategoryName: subCategory,
            description: description,
          )
        ];
        selectedCategory = null;
        file = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 1,
          dismissDirection: DismissDirection.horizontal,
          content: Center(
            child: const Text(
              'Category, SubCategory and File cannot be null',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.orange.shade800,
        ),
      );
      return;
    }
  }
}
