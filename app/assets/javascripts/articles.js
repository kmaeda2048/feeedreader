document.addEventListener('turbolinks:load', function () {
    // let shortcut = (e) => {
    function shortcut(e) {
        const keyName = e.key;
        switch (keyName) {
            case 'j':
                if (document.getElementById('focused-card') !== document.querySelector('.cards').lastElementChild) {
                    const previousCard = document.getElementById('focused-card');
                    const targetCard = previousCard.nextElementSibling;
                    previousCard.style.backgroundColor = '';
                    previousCard.removeAttribute('id');
                    targetCard.querySelector('.card-link').focus();
                    targetCard.setAttribute('id', 'focused-card');
                    targetCard.querySelector('.card-link').style.outline = 'none';
                    targetCard.style.backgroundColor = 'lightcyan';
                }
                break;
            case 'k':
                if (document.getElementById('focused-card') !== document.querySelector('.cards').firstElementChild) {
                    const nextCard = document.getElementById('focused-card');
                    const targetCard = nextCard.previousElementSibling;
                    nextCard.style.backgroundColor = '';
                    nextCard.removeAttribute('id');
                    targetCard.querySelector('.card-link').focus();
                    targetCard.setAttribute('id', 'focused-card');
                    targetCard.querySelector('.card-link').style.outline = 'none';
                    targetCard.style.backgroundColor = 'lightcyan';
                }
                break;
            case 'g':
                targetLink = document.getElementById('focused-card').querySelector('.card-link');
                window.location.href = targetLink;
                break;
            case 't':
                targetLink = document.getElementById('focused-card').querySelector('.card-link');
                window.open(targetLink, '_blank');
                break;
            case 's':
                const targetStar = document.getElementById('focused-card').querySelector('.star');
                targetStar.click();
                if (targetStar.style.backgroundColor === '') {
                    targetStar.style.backgroundColor = 'yellow';
                } else {
                    targetStar.style.backgroundColor = '';
                }
                break;
            case 'a':
                window.location.href = document.getElementById('articles-link');
                break;
            case 'q':
                window.location.href = document.getElementById('starred-articles-link');
                break;
        }
    }

    let targetLink;

    if (document.querySelector('.card')) {
        const firstCard = document.querySelector('.card');
        firstCard.querySelector('.card-link').focus();
        firstCard.setAttribute('id', 'focused-card');
        firstCard.querySelector('.card-link').style.outline = 'none';
        firstCard.style.backgroundColor = 'lightcyan';
    }

    document.addEventListener('keydown', shortcut);

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
    });
});
