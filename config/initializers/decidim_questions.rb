# frozen_string_literal: true

Decidim::QuestionCaptcha.configure do |config|
  config.questions = {
      fr: [
        { "question" => "Quelle est la capitale de la France ?", "answers" => "Paris,paris,PARIS" },
        { "question" => "1+1", "answers" => "2,deux,Deux,DEUX" },
        { "question" => "De quelle couleur est le chat noir ?", "answers" => "noir,Noir,NOIR" },
        { "question" => "Quel est le numéro de département de la Loire-Atlantique ?", "answers" => "44,quarante quatre,Quarante-quatre,QUARANTE-QUATRE" },
        { "question" => "Quelle est la seconde couleur de la liste : langue, gris, orange", "answers" => "orange,Orange,ORANGE" },
        { "question" => "Quel est le nombre le plus grand entre les nombres suivants : 18, cinq, quarante, cent", "answers" => "cent,100,Cent,CENT" },
        { "question" => "Combien font 15 moins un ?", "answers" => "quatorze,14,Quatorze,QUATORZE" },
        { "question" => "Parmi cinquante, soixante-seize, vingt-trois, un, 28 ou 77, lequel est le plus grand ?", "answers" => "77	soixante dix sept,soixante-dix-sept,Soixante-dix-sept,Soixante dix-sept,SOIXANTE-DIX-SEPT,SOIXANTE DIX-SEPT" },
        { "question" => "55+1", "answers" => "56,cinquante six,cinquante-six,Cinquante-six,CINQUANTE-SIX" },
        { "question" => "14, trente-cinq ou quarante-cinq : le plus petit est ?", "answers" => "14,quatorze,Quatorze" },
        { "question" => "Si les cheveux sont noirs, de quelle couleur sont les cheveux ?", "answers" => "noirs,noir,Noir,Noirs,NOIR,Noirs" },
        { "question" => "Rose, vert et coude : combien de couleurs dans la liste ?", "answers" => "2,deux,Deux,DEUX" },
        { "question" => "La liste bleu, doigt, rose, fromage, œil et pain contient combien de couleurs ?", "answers" => "2,deux,Deux,DEUX" }
      ],
      en: [
        { "question" => "1+5", "answers" => "6,six" },
        { "question" => "The blue hat is what color?", "answers" => "blue" },
        { "question" => "The green hat is what color?", "answers" => "green" },
        { "question" => "The yellow hat is what color?", "answers" => "yellow" },
        { "question" => "The red hat is what color?", "answers" => "red" }
      ],
      es: [
        { "question" => "1+2", "answers" => "3,tres" },
        { "question" => "El sombrero verde es de qué color?", "answers" => "verde" }
      ],
      ca: [
        { "question" => "2+2", "answers" => "4,quatre" },
        { "question" => "El barret verd és de quin color?", "answers" => "verd" }
      ]
  }
end
