import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../../modules/anime/animepahe_com/test.dart' as animepahe_com;
import '../../modules/anime/gogoanime_bid/test.dart' as gogoanime_bid;
import '../../modules/anime/hanime_tv/test.dart' as hanime_tv;
import '../../modules/manga/fanfox_net/test.dart' as fanfox_net;
import '../../modules/manga/mangadex_org/test.dart' as mangadex_org;
import '../../modules/manga/readm_org/test.dart' as readm_org;

abstract class TestModules {
  static final Map<TenkaLocalFileDS, MockedAnimeExtractor> anime =
      <TenkaLocalFileDS, MockedAnimeExtractor>{
    animepahe_com.source: gogoanime_bid.mocked,
    gogoanime_bid.source: gogoanime_bid.mocked,
    hanime_tv.source: hanime_tv.mocked,
  };

  static final Map<TenkaLocalFileDS, MockedMangaExtractor> manga =
      <TenkaLocalFileDS, MockedMangaExtractor>{
    fanfox_net.source: fanfox_net.mocked,
    mangadex_org.source: mangadex_org.mocked,
    readm_org.source: readm_org.mocked,
  };
}
