 import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:iara/ui/screens/home/home_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as Material;
import 'package:velocity_x/velocity_x.dart';

import 'window_buttons.dart';

class BaseWindow extends StatefulWidget {
  @override
  _BaseWindowState createState() => _BaseWindowState();

  const BaseWindow({super.key, required this.child});

  final Widget child;
}

class _BaseWindowState extends State<BaseWindow> {
  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.open;
  String pageTransition = 'Default';
  static const List<String> pageTransitions = [
    'Default',
    'Entrance',
    'Drill in',
    'Horizontal',
  ];
  String indicator = 'Sticky';
  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body:   _NavigationBodyItem( content: HomePage(),),
    ),
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(FluentIcons.issue_tracking),
      title: const Text('Track orders'),
      infoBadge: const InfoBadge(source: Text('8')),
      body: const _NavigationBodyItem(
        header: 'Badging',
        content: Text(
          'Badging is a non-intrusive and intuitive way to display '
              'notifications or bring focus to an area within an app - '
              'whether that be for notifications, indicating new content, '
              'or showing an alert. An InfoBadge is a small piece of UI '
              'that can be added into an app and customized to display a '
              'number, icon, or a simple dot.',
        ),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.disable_updates),
      title: const Text('Disabled Item'),
      body: const _NavigationBodyItem(),
      enabled: false,
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      body: const _NavigationBodyItem(
        header: 'PaneItemExpander',
        content: Text(
          'Some apps may have a more complex hierarchical structure '
              'that requires more than just a flat list of navigation '
              'items. You may want to use top-level navigation items to '
              'display categories of pages, with children items displaying '
              'specific pages. It is also useful if you have hub-style '
              'pages that only link to other pages. For these kinds of '
              'cases, you should create a hierarchical NavigationView.',
        ),
      ),
      items: [
        PaneItemHeader(header: const Text('Apps')),
        PaneItem(
          icon: const Icon(FluentIcons.mail),
          title: const Text('Mail'),
          body: const _NavigationBodyItem(),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.calendar),
          title: const Text('Calendar'),
          body: const _NavigationBodyItem(),
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Material.Scaffold(
      backgroundColor: Colors.white.withOpacity(.95),
      body: Column(
        children: <Widget>[
          WindowTitleBarBox(
            child: Row(
              children: <Widget>[MoveWindow(child: Container(),).expand() ,   WindowButtons()],
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            return NavigationView(
              appBar: const NavigationAppBar(
                title: Text('NavigationView'),
              ),
              pane: NavigationPane(
                selected: topIndex,
                onChanged: (index) => setState(() => topIndex = index),
                displayMode: constraints.maxWidth < 900? PaneDisplayMode.compact : PaneDisplayMode.open,
                items: items,
                footerItems: [
                  PaneItem(
                    icon: const Icon(FluentIcons.settings),
                    title: const Text('Settings'),
                    body: const _NavigationBodyItem(),
                  ),
                  PaneItemAction(
                    icon: const Icon(FluentIcons.add),
                    title: const Text('Add New Item'),
                    onTap: () {
                      // Your Logic to Add New `NavigationPaneItem`
                      items.add(
                        PaneItem(
                          icon: const Icon(FluentIcons.new_folder),
                          title: const Text('New Item'),
                          body: const Center(
                            child: Text(
                              'This is a newly added Item',
                            ),
                          ),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
 class _NavigationBodyItem extends StatelessWidget {
   const _NavigationBodyItem({
     this.header,
     this.content,
   });

   final String? header;
   final Widget? content;

   @override
   Widget build(BuildContext context) {
     return ScaffoldPage.withPadding(
       header: PageHeader(title: Text(header ?? 'This is a header text')),
       content: content ?? const SizedBox.shrink(),
     );
   }
 }
