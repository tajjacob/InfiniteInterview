import 'package:colour/colour.dart';
import 'package:flutter/material.dart';

class MyContactTab extends StatefulWidget {
  const MyContactTab({
    Key? key,
    required this.tab1,
    required this.tab2,
  }) : super(key: key);

  final Widget tab1;
  final Widget tab2;

  @override
  State<MyContactTab> createState() => _MyContactTabState();
}

class _MyContactTabState extends State<MyContactTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              // labelPadding: EdgeInsets.all(5),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[500],
              isScrollable: true,
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colour('#32baa5'),
                borderRadius: BorderRadius.circular(8), //Colour('#32baa1'),
              ),
              tabs: const [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text("All"),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Text("Favourite"),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height) / 2,
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
            controller: _tabController,
            children: [
              widget.tab1,
              widget.tab2,
            ],
          ),
        ),
      ],
    );
  }
}
