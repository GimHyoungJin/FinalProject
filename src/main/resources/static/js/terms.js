document.addEventListener("DOMContentLoaded", function() {
    // 부드러운 스크롤링 기능
    document.querySelectorAll('.terms-list a').forEach(function(anchor) {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
});