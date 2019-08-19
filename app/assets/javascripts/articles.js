document.addEventListener('turbolinks:load', function () {
    // let shortcut = (e) => {
    function shortcut(e) {
        const keyName = e.key;
        switch (keyName) {
            case 'j':
                if (document.getElementById('focused-card') !== document.querySelector('.mycards').lastElementChild) {
                    const previousCard = document.getElementById('focused-card');
                    const targetCard = previousCard.nextElementSibling;
                    previousCard.removeAttribute('id');
                    targetCard.setAttribute('id', 'focused-card');
                    targetCard.querySelector('.card-link').focus();
                }
                break;
            case 'k':
                if (document.getElementById('focused-card') !== document.querySelector('.mycards').firstElementChild) {
                    const nextCard = document.getElementById('focused-card');
                    const targetCard = nextCard.previousElementSibling;
                    nextCard.removeAttribute('id');
                    targetCard.setAttribute('id', 'focused-card');
                    targetCard.querySelector('.card-link').focus();
                }
                break;
            case 'g':
                {
                    const targetLink = document.getElementById('focused-card').querySelector('.card-link');
                    window.location.href = targetLink;
                    break;
                }
            case 't':
                {
                    const targetLink = document.getElementById('focused-card').querySelector('.card-link');
                    window.open(targetLink, '_blank');
                    break;
                }
            case 's':
                {
                    const targetStar = document.getElementById('focused-card').querySelector('.star');
                    targetStar.click();
                    targetStar.classList.toggle('starred');
                }
                break;
            case 'a':
                // window.location.href = document.querySelector('[data-link="articles"]');
                break;
            case 'q':
                // window.location.href = document.querySelector('[data-link="starred-articles"]');
                break;
        }
    }

    // const controller = document.body.dataset.controller;
    // const action = document.body.dataset.action;

    if (document.querySelector('.mycard')) {
        const firstCard = document.querySelector('.mycard');
        firstCard.setAttribute('id', 'focused-card');
        firstCard.querySelector('.card-link').focus();
    }

    document.addEventListener('keydown', shortcut);

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
    });
});
