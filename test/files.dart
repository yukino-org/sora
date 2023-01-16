import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../modules/anime/gogoanime_bid/test.dart' as gogoanime_bid;
import '../modules/anime/hanime_tv/test.dart' as hanime_tv;
import '../modules/anime/marin_moe/test.dart' as marin_moe;
import '../modules/anime/zoro_to/test.dart' as zoro_to;
import '../modules/manga/fanfox_net/test.dart' as fanfox_net;
import '../modules/manga/mangadex_org/test.dart' as mangadex_org;
import '../modules/manga/readm_org/test.dart' as readm_org;

abstract class TestFiles {
  static final Map<TenkaLocalFileDS, MockedAnimeExtractor> anime =
      <TenkaLocalFileDS, MockedAnimeExtractor>{
    gogoanime_bid.source: gogoanime_bid.mocked,
    hanime_tv.source: hanime_tv.mocked,
    marin_moe.source: marin_moe.mocked,
    zoro_to.source: zoro_to.mocked,
  };

  static final Map<TenkaLocalFileDS, MockedMangaExtractor> manga =
      <TenkaLocalFileDS, MockedMangaExtractor>{
    fanfox_net.source: fanfox_net.mocked,
    mangadex_org.source: mangadex_org.mocked,
    readm_org.source: readm_org.mocked,
  };
}
