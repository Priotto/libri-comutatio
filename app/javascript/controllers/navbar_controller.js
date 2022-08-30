

// export default class extends Controller {
//   connect() {
//     window.onscroll = function() {myFunction()};

//     var navbar = document.getElementById("navbar");


//     var sticky = navbar.offsetTop;

//     function myFunction() {
//       if (window.pageYOffset >= sticky) {
//         navbar.classList.add("sticky")
//       } else {
//         navbar.classList.remove("sticky");
//       }
//     }
//   }

//   updateNavbar() {
//     if (window.scrollY >= window.innerHeight) {
//       this.element.classList.add("navbar-white")
//     } else {
//       this.element.classList.remove("navbar-white")
//     }
//   }
// }


import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }
  updateNavbar() {
    if (window.scrollY >= window.innerHeight) {
      this.element.classList.add("navbar-white")
    } else {
      this.element.classList.remove("navbar-white")
    }
  }
}
