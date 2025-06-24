import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget desktopBody;
  final Widget? tvBody;


  final PreferredSizeWidget? mobileAppBar;
  final PreferredSizeWidget? tabletAppBar;
  final PreferredSizeWidget? desktopAppBar;
  final PreferredSizeWidget? tvAppBar;

  final Widget? mobileDrawer;
  final Widget? tabletDrawer;
  final Widget? desktopSidebar;

  final Widget? mobileBottomNavigationBar;
  final Widget? tabletBottomNavigationBar;

  // Breakpoints
  static const double mobileBreakpointMax = 599;
  static const double tabletBreakpointMin = 600;
  static const double tabletBreakpointMax = 1023;
  static const double desktopBreakpointMin = 1024;
  static const double desktopBreakpointMax = 1599; 
  static const double tvBreakpointMin = 1600;

  const ResponsiveLayout({
    required this.mobileBody,
    this.tabletBody,
    required this.desktopBody,
    this.tvBody,
    this.mobileAppBar,
    this.tabletAppBar,
    this.desktopAppBar,
    this.tvAppBar,
    this.mobileDrawer,
    this.tabletDrawer,
    this.desktopSidebar,
    this.mobileBottomNavigationBar,
    this.tabletBottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= tvBreakpointMin && tvBody != null) {
      // TV 
      return Scaffold(
        appBar: tvAppBar ?? desktopAppBar, 
        body: Row(
          children: [
            if (desktopSidebar != null) desktopSidebar!,
            Expanded(child: tvBody!),
          ],
        ),
      );
    } else if (width >= desktopBreakpointMin) {
      // Desktop 
      return Scaffold(
        appBar: desktopAppBar, 
        body: Row(
          children: [
            if (desktopSidebar != null) desktopSidebar!,
            Expanded(child: desktopBody),
          ],
        ),
      );
    } else if (width >= tabletBreakpointMin) {
      // Tablet 
      return Scaffold(
        appBar: tabletAppBar ?? mobileAppBar,
        drawer: tabletDrawer ?? mobileDrawer,
        body: tabletBody ?? mobileBody, 
        bottomNavigationBar: tabletBottomNavigationBar ?? mobileBottomNavigationBar,
      );
    } else {
      // Mobile 
      return Scaffold(
        appBar: mobileAppBar,
        drawer: mobileDrawer,
        body: mobileBody,
        bottomNavigationBar: mobileBottomNavigationBar,
      );
    }
  }
}
