import 'package:dio/dio.dart';

abstract class DataProvider {
  static const apiKey = '';
  static const jsonQuestionsData = <Map<String, dynamic>>[
    <String, dynamic>{
      'question_text': 'Быки реагируют на красный цвет.',
      'question_answer': false,
      'full_answer':
      'Быки практически не различают цветов. В корриде они реагируют не на красный, а на раздражающее размахивание плащом.',
    },
    <String, dynamic>{
      'question_text': 'Страусы от опасности прячут голову в песок.',
      'question_answer': false,
      'full_answer': 'Страусы, когда чувствуют опасность, убегают. Миф о том, что они закапываются, возник, возможно, из-за того, что, обессилев от долгой погони, они просто роняют голову со своей длинной шеей.',
    },
    <String, dynamic>{
      'question_text': 'Бананы растут на пальмах.',
      'question_answer': false,
      'full_answer': 'Банановое растение — это гигантская трава. А сами бананы — ягоды.',
    },
    <String, dynamic>{
      'question_text': 'Эйнштейн был двоечником.',
      'question_answer': false,
      'full_answer': 'Эйнштейн учился не отлично, но хорошо. Единственная низкая оценка в его аттестате — тройка по французскому.',
    },
    <String, dynamic>{
      'question_text': 'Курица может жить без головы.',
      'question_answer': true,
      'full_answer': 'Теряя голову, курицы способны прожить еще несколько минут, т. к. могут сохранить стволовую часть мозга. Достоверно известно о случае, когда цыпленок Майк из штата Колорадо в США без головы жил 18 месяцев. Все это время его кормили через пищевод.',
    },
    <String, dynamic>{
      'question_text': 'Летучие мыши слепые.',
      'question_answer': false,
      'full_answer': 'У летучих мышей вполне нормальное зрение. Они совмещают его возможности с эхолокацией.',
    },
    <String, dynamic>{
      'question_text': 'Молния не может ударить дважды в одно и то же место.',
      'question_answer': false,
      'full_answer': 'Молния способна ударить в одно место не два и даже не три раза. В некоторые здания она бьет до ста раз в год.',
    },
    <String, dynamic>{
      'question_text': 'Площадь суши России больше, чем у Плутона.',
      'question_answer': true,
      'full_answer': 'Площадь суши России — 17 млн км2. Это больше, чем у Плутона (16,6 млн  км2).',
    },
    <String, dynamic>{
      'question_text': 'Верблюды накапливают в горбах воду.',
      'question_answer': false,
      'full_answer': 'Верблюды накапливают в горбах не воду, а жир.',
    },
    <String, dynamic>{
      'question_text': 'Фраза «И все-таки она вертится!» принадлежит Галилею.',
      'question_answer': false,
      'full_answer': 'Информация о фразе «И все-таки она вертится» появилась спустя 5 лет после смерти Галилея. Так что это скорее красивый миф, чем правда.',
    },
    <String, dynamic>{
      'question_text': 'Если взять в руку лягушку — появится бородавка.',
      'question_answer': false,
      'full_answer': 'Бородавки могут появиться на руках от вируса папилломы человека. Но не лягушки.',
    },
    <String, dynamic>{
      'question_text': 'Если много смеяться — на лице появятся мимические морщины.',
      'question_answer': false,
      'full_answer': 'Смех кожу не старит, а напротив, тонизирует.',
    },
    <String, dynamic>{
      'question_text': 'Нервные клетки не восстанавливаются.',
      'question_answer': false,
      'full_answer': 'В мозге постоянно происходит процесс нейрогенеза — образования новых нервных клеток из клеток-предшественниц. С возрастом процесс замедляется. Но все же идет!',
    },
    <String, dynamic>{
      'question_text': 'Во Вселенной больше звезд, чем песчинок на пляжах Земли.',
      'question_answer': true,
      'full_answer': 'Во Вселенной больше звезд, чем песчинок на пляжах Земли.',
    },
    <String, dynamic>{
      'question_text': 'Великая Китайская стена — единственный рукотворный объект на Земле, видимый из космоса.',
      'question_answer': false,
      'full_answer': 'С низкой орбиты можно увидеть отнюдь не только Великую Китайскую стену. Египетские пирамиды, например, видно ничуть не хуже.',
    },
  ];
  static Future<Response> getPhoto(){
    const clientId = 'c1oJzOrdHEl9fu9IKiO4Ocv_Gihk8Cl3mvgFoJpuXCg';
    const clientSecret = '2fd6CSG1lujjheDhGPf58psnw9BuGtd9quzv9756UxE';

    final result = Dio().get('https://api.unsplash.com/photos/random', queryParameters: {
      'client_id': clientId,
      'client_secret': clientSecret
    });
    return result;
  }
}