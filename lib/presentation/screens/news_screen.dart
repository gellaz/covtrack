import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business/blocs/news/news_bloc.dart';
import '../../business/repositories/news/api_news_repository.dart';
import '../../business/repositories/news/news_repository.dart';
import '../../data/news.dart';
import '../../utils/app_localizations.dart';
import '../widgets/info_list_view.dart';
import '../widgets/logout_button.dart';

/// Container class used to provide the [NewsBloc] to the class
/// [NewsScreenContent] containing the actual content of the screen.
class NewsScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final NewsRepository newsRepository = ApiNewsRepository();

    return BlocProvider(
      create: (_) =>
          NewsBloc(newsRepository: newsRepository)..add(NewsFetched()),
      child: NewsScreenContent(),
    );
  }
}

/// Content of the [NewsScreen]. The content shown on the page depends
/// on the status of the [NewsBloc].
class NewsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).news),
        actions: <Widget>[LogoutButton()],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadInProgress) {
            return _buildLoading();
          } else if (state is NewsLoadSuccess) {
            return _buildLoadedData(
              context,
              state.localNews,
              state.globalNews,
            );
          } else if (state is NewsLoadFailure) {
            return _buildInitial();
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildInitial() {
    return Center(
      child: Text('Initial'),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedData(
    BuildContext context,
    News localNews,
    News globalNews,
  ) {
    return RefreshIndicator(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                _buildDescription(context),
                _buildDivider(),
                _buildNewsTitle(
                  context,
                  AppLocalizations.of(context).italy,
                  localNews.date,
                ),
                NewsListView(localNews),
                _buildDivider(),
                _buildNewsTitle(
                  context,
                  AppLocalizations.of(context).global,
                  globalNews.date,
                ),
                NewsListView(globalNews),
                _buildDivider(),
                _buildDisclaimer(context),
              ],
            ),
          ),
        ],
      ),
      onRefresh: () async => context.bloc<NewsBloc>().add(NewsFetched()),
    );
  }

  Padding _buildDivider() {
    return const Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Divider(),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      AppLocalizations.of(context).newsDescription,
      style: Theme.of(context).accentTextTheme.bodyText2,
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildNewsTitle(
    BuildContext context,
    String title,
    DateTime lastUpdate,
  ) {
    final formattedLastUpdate = DateFormat.yMd().format(lastUpdate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            AppLocalizations.of(context).lastUpdate(formattedLastUpdate),
            style: Theme.of(context).accentTextTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer(BuildContext context) {
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: AppLocalizations.of(context).newsDisclaimer,
            style: Theme.of(context).accentTextTheme.caption,
            children: <TextSpan>[
              TextSpan(text: ' '),
              TextSpan(
                text: 'covidapi.info',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.lightBlue,
                      decoration: TextDecoration.underline,
                    ),
                recognizer: TapGestureRecognizer()..onTap = _onTap,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _onTap() async {
    if (await canLaunch('https://covidapi.info/')) {
      await launch('https://covidapi.info/');
    } else {
      throw Exception('Cannot launch https://covidapi.info/');
    }
  }
}
