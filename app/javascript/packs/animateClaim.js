import Typed from 'typed.js';

const animateClaim = () => {
  const element = document.querySelector(".changing");
  if (element) {
    var options = {
    strings: ["une perceuse à bois", "un décapeur thermique", "un pistolet à colle", "une meuleuse à poutre", "une scie sauteuse", "une élagueuse de jardin", "une tondeuse à gazon", "une grande échelle", "une carotteuse", "un marteau arrache clou", "une défonceuse"],
    typeSpeed: 20,
    loop: true,
    shuffle: true,
    startDelay: 5,
    smartBackspace: false,
  }

  var typed = new Typed(element, options);
  }
};

export { animateClaim };
