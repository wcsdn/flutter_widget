import 'package:flutter/material.dart';
import 'package:flutter_widget/widgets/stick_widget.dart';

class StickTab extends StatefulWidget {
  @override
  _StickTabState createState() => _StickTabState();
}

class _StickTabState extends State<StickTab> {
  final List<String> _allPages = [
    '语文',
    '英语',
  ];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      length: _allPages.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  title: const Text('Tabs and scrolling'),
                  actions: <Widget>[],
                  pinned: true,
                  expandedHeight: 400.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _allPages
                        .map<Widget>(
                          (String value) => Tab(text: value),
                        )
                        .toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _allPages.map<Widget>((String value) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      physics: ClampingScrollPhysics(),
                      key: PageStorageKey<String>(value),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: SliverFixedExtentList(
                            itemExtent: 40.0,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Text('data'),
                                );
                              },
                              childCount: 350,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
