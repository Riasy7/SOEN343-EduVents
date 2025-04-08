// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails";
// import "controllers";
// import Rails from "@rails/ujs";
// Rails.start();

//Flatpicker
import "@hotwired/turbo-rails";
import "controllers";
import flatpickr from "flatpickr";
import "chartkick";
import "Chart.bundle";

document.addEventListener("turbo:load", () => {
  flatpickr(".datetime-picker.start-time", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    minDate: "today",
    defaultHour: 9,
    onChange: function (selectedDates) {
      const endInput = document.querySelector(".datetime-picker.end-time");
      if (endInput && endInput._flatpickr && selectedDates[0]) {
        const oneHourLater = new Date(selectedDates[0].getTime() + 60 * 60 * 1000);
        endInput._flatpickr.setDate(oneHourLater, true);
      }
    }
  });

  flatpickr(".datetime-picker.end-time", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    minDate: "today"
  });
});
