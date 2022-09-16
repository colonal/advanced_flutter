import 'dart:async';

import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/usecase/search_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

class SearchViewmodel extends BaseViewModel
    with SearchViewmodelInput, SearchViewmodelOutpot {
  final SearchUsecase searchUsecase;

  StreamController<SearchObject?> searchController =
      StreamController<SearchObject>.broadcast();

  SearchViewmodel({required this.searchUsecase});

  SearchViewmodelObject object = SearchViewmodelObject("");

  @override
  Sink get inputSearch => searchController.sink;

  @override
  Stream<SearchObject?> get outpotSearch =>
      searchController.stream.map((search) => search);

  @override
  void start() {
    inputState.add(ContentState());
  }

  _getSeach() async {
    inputState.add(LoadingProgressState(
        stateRendererType: StateRendererType.progressBarWidget));
    (await searchUsecase.execute(SearchUsecaseInput(search: object.seach)))
        .fold(
      (failure) => {
        // left -> failure
        inputState.add(
          ContentState(),
        ),
        searchController.add(null),
      },
      (data) {
        inputState.add(ContentState());
        searchController.add(data);
      },
    );
  }

  @override
  void dispose() {
    searchController.close();
    super.dispose();
  }

  @override
  setSearch(String search) {
    object = object.copyWith(seach: search);
    if (search.isNotEmpty) {
      _getSeach();
    }
  }
}

abstract class SearchViewmodelInput {
  setSearch(String search);
  Sink get inputSearch;
}

abstract class SearchViewmodelOutpot {
  Stream<SearchObject?> get outpotSearch;
}
