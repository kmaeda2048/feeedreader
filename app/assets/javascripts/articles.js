document.addEventListener('turbolinks:load', function () {
    // let shortcut = (e) => {
    function shortcut(e) {
        const keyName = e.key;
        switch (keyName) {
            case 'j':
                if (document.activeElement.className !== 'card-link') {
                    const firstCard = document.querySelector('.card');
                    firstCard.querySelector('.card-link').focus();
                    firstCard.setAttribute('id', 'focused-card');
                    firstCard.querySelector('.card-link').style.outline = 'none';
                    firstCard.style.backgroundColor = 'lightcyan';
                } else {
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
                if (document.activeElement.className === 'card-link') {
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
            case 'o':
                if (document.activeElement.className === 'card-link') {
                    const targetLink = document.getElementById('focused-card').querySelector('.card-link');
                    window.location.href = targetLink;
                }
                break;
            case 'g':
                if (document.activeElement.className === 'card-link') {
                    const targetLink = document.getElementById('focused-card').querySelector('.card-link');
                    window.open(targetLink, '_blank');
                }
                break;
            case 's':
                if (document.activeElement.className === 'card-link') {
                    const targetStar = document.getElementById('focused-card').querySelector('.star');
                    targetStar.click();
                    if (targetStar.style.backgroundColor === '') {
                        targetStar.style.backgroundColor = 'yellow';
                    } else {
                        targetStar.style.backgroundColor = '';
                    }
                }
                break;
        }
    }

    const controller = document.querySelector('body').dataset.controller;
    const action = document.querySelector('body').dataset.action;

    if (controller === 'articles' && (action === 'index' || action === 'starred')) {
        document.addEventListener('keydown', shortcut);
    }

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
    });
});
