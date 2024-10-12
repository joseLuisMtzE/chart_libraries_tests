import 'package:chart_libraries_tests/presentation/screens/fl_charts/bars_fl_screen.dart';
import 'package:chart_libraries_tests/presentation/screens/fl_charts/circular_fl_screen.dart';
import 'package:chart_libraries_tests/presentation/screens/fl_charts/fl_charts_screen.dart';
import 'package:chart_libraries_tests/presentation/screens/fl_charts_zoom/bars_fl_screen_zoom.dart';
import '../../presentation/screens/fl_charts/lineal_fl_screen.dart';
import 'package:chart_libraries_tests/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    //??   FL CHARTS
    GoRoute(
      path: '/fl-charts',
      builder: (context, state) => const FlChartsScreen(),
    ),
    GoRoute(
      path: '/fl-lineal',
      builder: (context, state) => const LinealFlScreen(),
    ),
    GoRoute(
      path: '/fl-circular',
      builder: (context, state) => const CircularFlScreen(),
    ),
    GoRoute(
      path: '/fl-bars',
      builder: (context, state) => BarsFlScreen(),
    ),
    //?? FL CHARTS TEST ZOOM
      GoRoute(
      path: '/fl-charts-zoom',
      builder: (context, state) =>  FlChartsZoomScreen(),
    ),
  ],
);
