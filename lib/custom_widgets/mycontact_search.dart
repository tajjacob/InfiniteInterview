import 'package:flutter/material.dart';

class MyContactSearch extends StatefulWidget {
  const MyContactSearch({Key? key}) : super(key: key);

  @override
  State<MyContactSearch> createState() => _MyContactSearchState();
}

class _MyContactSearchState extends State<MyContactSearch> {
  // Regres? regres;
  // List<Data>? dataList;
  //
  // Future<List<Data>> getData(filter) async {
  //   var response = await Dio().get(
  //     Const.contactApiUrl,
  //     queryParameters: {"first_name": filter},
  //   );
  //
  //   final data = response.data;
  //   if (data != null) {
  //     return Data.fromJsonList(data).toList();
  //   }
  //
  //   return [];
  // }
  //
  // Future<List<Data>?> getUserList() async {
  //   final response = await http.get(Uri.parse(Const.contactApiUrl));
  //   if (response.statusCode == 200) {
  //     regres = Regres.fromJson(jsonDecode(response.body));
  //     setState(() {
  //       dataList = regres!.data;
  //     });
  //     return dataList;
  //   } else {
  //     dataList = null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(15),
      child:
          // DropdownSearch<Data>(
          //   showSelectedItems: true,
          //   compareFn: (i, s) => i?.isEqual(s) ?? false,
          //   dropdownSearchDecoration: InputDecoration(
          //     labelText: "Person",
          //     contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          //     border: OutlineInputBorder(),
          //   ),
          //   onFind: (String? filter) => getData(filter),
          //   onChanged: (data) {
          //     print(data);
          //   },
          //   dropdownBuilder: _customDropDownExample,
          //   // popupItemBuilder: _customPopupItemBuilderExample2,
          // ),
          TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search Contact',
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: (Colors.grey[300])!,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: _controller.clear,
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
  //
  // Widget _customDropDownExample(BuildContext context, Data? item) {
  //   if (item == null) {
  //     return Container();
  //   }
  //
  //   return Container(
  //     child: (item.avatar == null)
  //         ? ListTile(
  //             contentPadding: EdgeInsets.all(0),
  //             leading: CircleAvatar(),
  //             title: Text("No item selected"),
  //           )
  //         : ListTile(
  //             contentPadding: EdgeInsets.all(0),
  //             leading: CircleAvatar(
  //                 // this does not work - throws 404 error
  //                 // backgroundImage: NetworkImage(item.avatar ?? ''),
  //                 ),
  //             title: Text(item.firstName.toString()),
  //             // subtitle: Text(
  //             //   item.lastName.toString(),
  //             // ),
  //           ),
  //   );
  // }
  //
  // Widget _customPopupItemBuilderExample2(
  //     BuildContext context, Data? item, bool isSelected) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 8),
  //     decoration: !isSelected
  //         ? null
  //         : BoxDecoration(
  //             border: Border.all(color: Theme.of(context).primaryColor),
  //             borderRadius: BorderRadius.circular(5),
  //             color: Colors.white,
  //           ),
  //     child: ListTile(
  //       selected: isSelected,
  //       title: Text(item?.firstName ?? ''),
  //       // subtitle: Text(item?.lastName?.toString() ?? ''),
  //       leading: CircleAvatar(
  //           // this does not work - throws 404 error
  //           // backgroundImage: NetworkImage(item.avatar ?? ''),
  //           ),
  //     ),
  //   );
  // }
}
