import 'package:flutter/material.dart';
import '../widgets/DocumentsListView.dart';

class DocumentsScreen extends StatefulWidget {
  final String? subRoute;
  const DocumentsScreen({Key? key, this.subRoute}) : super(key: key);
  static const routeName = '/documents';

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

enum FilterOptions { name, date, birthDate }

class _DocumentsScreenState extends State<DocumentsScreen> {
  final _searchController = TextEditingController();
  bool isDescendingOrder = false;
  List<String> displayDocuments = [];
  //TODO: change type from String to a document data model
  List<String> documents = [
    "bye",
    "yeet",
    "sheeeesh",
    "yolo",
    "ayy",
    "hello",
  ];

  void _onSelectedSort(FilterOptions options) {
    switch (options) {
      case FilterOptions.name:
        setState(() {
          isDescendingOrder = !isDescendingOrder;
          if (!isDescendingOrder) {
            displayDocuments.sort((a, b) => b.compareTo(a));
          } else {
            displayDocuments.sort((a, b) => a.compareTo(b));
          }
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    displayDocuments = List.from(documents);
    super.initState();
    _searchController.addListener(() {
      setState(() {
        displayDocuments = documents
            .where((doc) => doc.contains(_searchController.text))
            .toList();
        if (!isDescendingOrder) {
          displayDocuments.sort((a, b) => b.compareTo(a));
        } else {
          displayDocuments.sort((a, b) => a.compareTo(b));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double widthPadding = queryData.size.width * 0.05;
    double heightPadding = queryData.size.height * 0.02;

    return Column(
      children: [
        // search bar
        Padding(
          padding: EdgeInsets.only(
            top: 3,
            left: widthPadding,
            right: widthPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    offset: Offset(0, 2.0)),
              ],
            ),
            width: queryData.size.width,
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 16.0),
              decoration: const InputDecoration(
                hintText: "Search",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  gapPadding: 1.0,
                ),
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        // documents menu bar
        Padding(
          padding: EdgeInsets.only(
            left: widthPadding,
            right: widthPadding,
            top: heightPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Documents",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    splashRadius: 1.0,
                    onPressed: () => {print("Pressed create new folder!")},
                    icon: Icon(
                      Icons.create_new_folder,
                      size: 28.0,
                      color: Colors.blueAccent.withOpacity(0.5),
                    ),
                  ),
                  PopupMenuButton(
                    position: PopupMenuPosition.under,
                    splashRadius: 1.0,
                    onSelected: _onSelectedSort,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<FilterOptions>>[
                      const PopupMenuItem<FilterOptions>(
                        value: FilterOptions.name,
                        child: Text('Name'),
                      ),
                      const PopupMenuItem<FilterOptions>(
                        value: FilterOptions.date,
                        child: Text('Date'),
                      ),
                      const PopupMenuItem<FilterOptions>(
                        value: FilterOptions.birthDate,
                        child: Text('Birth Date'),
                      ),
                    ],
                    icon: Icon(Icons.menu,
                        size: 28, color: Colors.blueAccent.withOpacity(0.5)),
                  )
                ],
              )
            ],
          ),
        ),
        // documents listviews
        Expanded(
          flex: 5,
          child: DocumentsListView(
            documentsList: displayDocuments,
            isDescending: true,
          ),
        )
      ],
    );
  }
}
