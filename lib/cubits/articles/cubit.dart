import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/constants/constants.dart';

import 'package:news_app/models/article/article.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  static ArticlesCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ArticlesCubit>(context, listen: listen);

  ArticlesCubit() : super(ArticlesDefault());

  final repo = ArticlesRepository();

  Future<void> fetch({String? keyword}) async {
    emit(const ArticlesFetchLoading());
    try {
      final data = await repo.fetch(keyword: keyword);

      emit(ArticlesFetchSuccess(data: data));
    } catch (e) {
      emit(ArticlesFetchFailed(message: e.toString()));
    }
  }
}
