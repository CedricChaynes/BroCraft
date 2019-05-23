import Typed from 'typed.js';

const animateClaim = () => {
  const element = document.querySelector(".changing");
  if (element) {
    var options = {
    strings: ["une perceuse", "un décapeur", "un pistolet à colle", "une meuleuse", "une scie sauteuse", "une élagueuse de jardin", "une tondeuse à gazon", "une grande échelle", "une carotteuse"],
    typeSpeed: 20,
    loop: true,
  }

  var typed = new Typed(element, options);
  }
};

export { animateClaim };
