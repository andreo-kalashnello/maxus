document.addEventListener('DOMContentLoaded', function () {
    var menuToggle = document.getElementById('menuToggle');
    var nav = document.querySelector('.nav');

    if (menuToggle && nav) {
        menuToggle.addEventListener('click', function () {
            menuToggle.classList.toggle('active');
            nav.classList.toggle('open');
        });

        nav.querySelectorAll('a').forEach(function (link) {
            link.addEventListener('click', function () {
                menuToggle.classList.remove('active');
                nav.classList.remove('open');
            });
        });
    }

    var faqQuestions = document.querySelectorAll('.faq-question');
    faqQuestions.forEach(function (question) {
        question.addEventListener('click', function () {
            var item = question.parentElement;
            if (!item) {
                return;
            }

            item.classList.toggle('active');
            var toggle = question.querySelector('.faq-toggle');
            if (toggle) {
                toggle.textContent = item.classList.contains('active') ? '-' : '+';
            }
        });
    });

    var quickAnswerButtons = document.querySelectorAll('.quick-answer-btn');
    quickAnswerButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var item = btn.closest('.quick-answer-item');
            if (!item) {
                return;
            }

            item.classList.toggle('active');
        });
    });
});
