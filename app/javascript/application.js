// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core";
import "bootstrap";

document.addEventListener("turbo:load", () => {
  console.log("turbo")
  document.querySelectorAll(".horizontal-cards").forEach((container) => {
    container.addEventListener("wheel", (e) => {
      e.preventDefault();
      container.scrollLeft += e.deltaY;
    });
  });
});
