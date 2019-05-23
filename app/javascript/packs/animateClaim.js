import Typed from 'typed.js';

const animateClaim = () => {
  const element = document.querySelector(".changing");
  if (element) {
    var options = {
    strings: ["une perceuse à bois", "un décapeur thermique", "un pistolet à colle", "une meuleuse à poutre", "une scie sauteuse", "un Pokémon", "une élagueuse de jardin", "une meilleure tireuse à bière que chez AirBnMousse", "une tondeuse à gazon", "une grande échelle", "une carotteuse", "une meilleure tireuse à bière que chez AirBnMousse", "un marteau arrache clou", "une défonceuse"],
    typeSpeed: 30,
    loop: true,
    shuffle: true,
    startDelay: 5,
    smartBackspace: false,
  }

  var typed = new Typed(element, options);
  }
};

export { animateClaim };
