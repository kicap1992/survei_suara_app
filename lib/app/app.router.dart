// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cek_suara_app/ui/views/login_screen/login_screen_view.dart'
    as _i3;
import 'package:cek_suara_app/ui/views/splash_screen/splash_screen_view.dart'
    as _i2;
import 'package:cek_suara_app/ui/views/tim_survei_index_tracking/first_page/first_page_view.dart'
    as _i6;
import 'package:cek_suara_app/ui/views/tim_survei_index_tracking/halaman_history/halaman_history_view.dart'
    as _i8;
import 'package:cek_suara_app/ui/views/tim_survei_index_tracking/halaman_pengaturan/halaman_pengaturan_view.dart'
    as _i9;
import 'package:cek_suara_app/ui/views/tim_survei_index_tracking/halaman_survei/halaman_survei_view.dart'
    as _i7;
import 'package:cek_suara_app/ui/views/tim_survei_index_tracking/tim_survei_index_tracking_view.dart'
    as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const splashScreenView = '/';

  static const loginScreenView = '/login-screen-view';

  static const timSurveiIndexTrackingView = '/tim-survei-index-tracking-view';

  static const all = <String>{
    splashScreenView,
    loginScreenView,
    timSurveiIndexTrackingView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreenView,
      page: _i2.SplashScreenView,
    ),
    _i1.RouteDef(
      Routes.loginScreenView,
      page: _i3.LoginScreenView,
    ),
    _i1.RouteDef(
      Routes.timSurveiIndexTrackingView,
      page: _i4.TimSurveiIndexTrackingView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreenView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreenView(),
        settings: data,
      );
    },
    _i3.LoginScreenView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginScreenView(),
        settings: data,
      );
    },
    _i4.TimSurveiIndexTrackingView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.TimSurveiIndexTrackingView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TimSurveiIndexTrackingViewRoutes {
  static const firstPageView = '';

  static const halamanSurveiView = 'halaman-survei-view';

  static const halamanHistoryView = 'halaman-history-view';

  static const halamanPengaturanView = 'halaman-pengaturan-view';

  static const all = <String>{
    firstPageView,
    halamanSurveiView,
    halamanHistoryView,
    halamanPengaturanView,
  };
}

class TimSurveiIndexTrackingViewRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      TimSurveiIndexTrackingViewRoutes.firstPageView,
      page: _i6.FirstPageView,
    ),
    _i1.RouteDef(
      TimSurveiIndexTrackingViewRoutes.halamanSurveiView,
      page: _i7.HalamanSurveiView,
    ),
    _i1.RouteDef(
      TimSurveiIndexTrackingViewRoutes.halamanHistoryView,
      page: _i8.HalamanHistoryView,
    ),
    _i1.RouteDef(
      TimSurveiIndexTrackingViewRoutes.halamanPengaturanView,
      page: _i9.HalamanPengaturanView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i6.FirstPageView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.FirstPageView(),
        settings: data,
      );
    },
    _i7.HalamanSurveiView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.HalamanSurveiView(),
        settings: data,
      );
    },
    _i8.HalamanHistoryView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.HalamanHistoryView(),
        settings: data,
      );
    },
    _i9.HalamanPengaturanView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.HalamanPengaturanView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTimSurveiIndexTrackingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.timSurveiIndexTrackingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedFirstPageViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(TimSurveiIndexTrackingViewRoutes.firstPageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedHalamanSurveiViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(
        TimSurveiIndexTrackingViewRoutes.halamanSurveiView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedHalamanHistoryViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(
        TimSurveiIndexTrackingViewRoutes.halamanHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      navigateToNestedHalamanPengaturanViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(
        TimSurveiIndexTrackingViewRoutes.halamanPengaturanView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTimSurveiIndexTrackingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.timSurveiIndexTrackingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedFirstPageViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(TimSurveiIndexTrackingViewRoutes.firstPageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedHalamanSurveiViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(
        TimSurveiIndexTrackingViewRoutes.halamanSurveiView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedHalamanHistoryViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(
        TimSurveiIndexTrackingViewRoutes.halamanHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic>
      replaceWithNestedHalamanPengaturanViewInTimSurveiIndexTrackingViewRouter([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(
        TimSurveiIndexTrackingViewRoutes.halamanPengaturanView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
