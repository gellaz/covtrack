import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/info.dart';
import '../../repositories/info/info_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final InfoRepository infoRepository;

  InfoBloc(this.infoRepository) : assert(infoRepository != null);

  @override
  InfoState get initialState => InfoInitial();

  @override
  Stream<InfoState> mapEventToState(InfoEvent event) async* {
    if (event is InfoFetched) {
      yield InfoLoadInProgress();
      try {
        final localInfo = await infoRepository.getCountryLatestInfo();
        final globalInfo = await infoRepository.getGlobalLatestInfo();
        yield InfoLoadSuccess(localInfo, globalInfo);
      } catch (e) {
        yield InfoLoadFailure(e.toString());
      }
    }
  }
}
