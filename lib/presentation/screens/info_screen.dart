import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business/blocs/info/info_bloc.dart';
import '../../business/repositories/info/info_repository.dart';
import '../../data/models/info.dart';
import '../../utils/app_localizations.dart';
import '../widgets/info_list_view.dart';
import '../widgets/logout_button.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfoBloc(context.repository<InfoRepository>())..add(InfoFetched()),
      child: InfoContent(),
    );
  }
}

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        actions: <Widget>[
          LogoutButton(),
        ],
      ),
      body: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          if (state is InfoLoadInProgress) {
            return _buildLoading();
          } else if (state is InfoLoadSuccess) {
            return _buildLoadedData(
              context,
              state.localInfo,
              state.globalInfo,
            );
          } else if (state is InfoLoadFailure) {
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
    Info localInfo,
    Info globalInfo,
  ) {
    return RefreshIndicator(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                _buildDescription(context),
                SizedBox(height: 40),
                _buildInfoTitle(
                  context,
                  AppLocalizations.of(context).italy,
                  localInfo.date,
                ),
                InfoListView(localInfo),
                SizedBox(height: 40),
                _buildInfoTitle(
                  context,
                  AppLocalizations.of(context).global,
                  globalInfo.date,
                ),
                InfoListView(globalInfo),
                SizedBox(height: 40),
                _buildDisclaimer(context),
              ],
            ),
          ),
        ],
      ),
      onRefresh: () async => context.bloc<InfoBloc>().add(InfoFetched()),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      AppLocalizations.of(context).infoDescription,
      style: Theme.of(context).textTheme.bodyText2,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInfoTitle(
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
            style: Theme.of(context).textTheme.overline,
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
            text: AppLocalizations.of(context).infoDisclaimer,
            style: Theme.of(context).textTheme.overline,
            children: <TextSpan>[
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
