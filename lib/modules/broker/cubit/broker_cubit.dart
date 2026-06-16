import '../../../utils/exports.dart';

class BrokerCubit extends BaseCubit<BrokerState> {
  BrokerCubit() : super(BrokerState.initial()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    emit(state.copyWith(
      brokers: _getMockBrokers(),
      status: BaseStateStatus.success,
    ));
  }

  Future<void> openBrokerLink(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: 'Could not launch registration link.',
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Error launching broker link: ${e.toString()}',
      ));
    }
  }

  List<BrokerModel> _getMockBrokers() {
    return const <BrokerModel>[
      BrokerModel(
        id: 'broker_vantage',
        name: 'Vantage',
        brokerType: 'Forex Broker',
        badge: 'Top Forex Broker',
        assets: 'Forex, CFDs, Indices',
        rating: 4.8,
        ratingText: 'Excellent',
        reviewsCount: '8.2K+',
        accountsCount: '1M+',
        logoUrl: 'https://logo.clearbit.com/vantagemarkets.com?size=120',
        redirectUrl: 'https://www.vantagemarkets.com',
      ),
      BrokerModel(
        id: 'broker_vtmarkets',
        name: 'VT Markets',
        brokerType: 'Forex Broker',
        badge: 'Popular Broker',
        assets: 'Forex, Commodities, Crypto CFDs',
        rating: 4.7,
        ratingText: 'Trusted',
        reviewsCount: '6.4K+',
        accountsCount: '800K+',
        logoUrl: 'https://logo.clearbit.com/vtmarkets.com?size=120',
        redirectUrl: 'https://www.vtmarkets.com',
      ),
      BrokerModel(
        id: 'broker_pepperstone',
        name: 'Pepperstone',
        brokerType: 'Forex Broker',
        badge: 'Professional',
        assets: 'Forex, Indices, Metals',
        rating: 4.9,
        ratingText: 'Excellent',
        reviewsCount: '9.7K+',
        accountsCount: '1.3M+',
        logoUrl: 'https://logo.clearbit.com/pepperstone.com?size=120',
        redirectUrl: 'https://pepperstone.com',
      ),
      BrokerModel(
        id: 'broker_coinswitch',
        name: 'Coinswitch',
        brokerType: 'Crypto Broker',
        badge: 'Beginner Friendly',
        assets: 'Crypto, Spot',
        rating: 4.5,
        ratingText: 'Secure',
        reviewsCount: '5.2K+',
        accountsCount: '900K+',
        logoUrl: 'https://logo.clearbit.com/coinswitch.co?size=120',
        redirectUrl: 'https://coinswitch.co',
      ),
      BrokerModel(
        id: 'broker_binance',
        name: 'Binance',
        brokerType: 'Crypto Broker',
        badge: 'Top Rated',
        assets: 'Crypto, Futures, Spot',
        rating: 4.9,
        ratingText: 'Excellent',
        reviewsCount: '12.5K+',
        accountsCount: '300M+',
        logoUrl: 'https://logo.clearbit.com/binance.com?size=120',
        redirectUrl: 'https://www.binance.com',
      ),
      BrokerModel(
        id: 'broker_lemonn',
        name: 'Lemonn',
        brokerType: 'Stock Broker',
        badge: 'Modern Investing',
        assets: 'Stocks, ETF, Mutual Funds',
        rating: 4.5,
        ratingText: 'Modern',
        reviewsCount: '3.4K+',
        accountsCount: '500K+',
        logoUrl: 'https://logo.clearbit.com/lemonn.co.in?size=120',
        redirectUrl: 'https://lemonn.co.in',
      ),
      BrokerModel(
        id: 'broker_arihant',
        name: 'Arihant Capitals',
        brokerType: 'Stock Broker',
        badge: 'Trusted Broker',
        assets: 'Stocks, IPO, Commodity',
        rating: 4.4,
        ratingText: 'Reliable',
        reviewsCount: '2.9K+',
        accountsCount: '350K+',
        logoUrl: 'https://logo.clearbit.com/arihantcapital.com?size=120',
        redirectUrl: 'https://www.arihantcapital.com',
      ),
      BrokerModel(
        id: 'broker_zerodha',
        name: 'Zerodha',
        brokerType: 'Stock Broker',
        badge: 'India #1',
        assets: 'Stocks, F&O, Mutual Funds',
        rating: 4.9,
        ratingText: 'Excellent',
        reviewsCount: '15K+',
        accountsCount: '5M+',
        logoUrl: 'https://logo.clearbit.com/zerodha.com?size=120',
        redirectUrl: 'https://zerodha.com',
      ),
      BrokerModel(
        id: 'broker_groww',
        name: 'Groww',
        brokerType: 'Stock Broker',
        badge: 'Easy Investing',
        assets: 'Stocks, ETF, IPO',
        rating: 4.7,
        ratingText: 'Popular',
        reviewsCount: '10K+',
        accountsCount: '3M+',
        logoUrl: 'https://logo.clearbit.com/groww.in?size=120',
        redirectUrl: 'https://groww.in',
      ),
      BrokerModel(
        id: 'broker_angelone',
        name: 'AngelOne',
        brokerType: 'Stock Broker',
        badge: 'Full Service',
        assets: 'Stocks, Commodity, F&O',
        rating: 4.6,
        ratingText: 'Trusted',
        reviewsCount: '7.8K+',
        accountsCount: '1.8M+',
        logoUrl: 'https://logo.clearbit.com/angelone.in?size=120',
        redirectUrl: 'https://www.angelone.in',
      ),
    ];
  }

  @override
  BrokerState getResetErrorState() => state.copyWith(msg: '');

  @override
  BrokerState getResetRedirectionState() => state.copyWith();
}
