document.addEventListener('turbolinks:load', function () {
    // let shortcut = (e) => {
    function shortcut(e) {
        const keyName = e.key;
        switch (keyName) {
            case 'j':
                if (document.getElementById('focused-card') !== document.querySelector('.cards').lastElementChild) {
                    const previousCard = document.getElementById('focused-card');
                    const targetCard = previousCard.nextElementSibling;
                    previousCard.removeAttribute('id');
                    targetCard.setAttribute('id', 'focused-card');
                    targetCard.querySelector('.card-link').setAttribute('id', 'focused-link');
                    targetCard.querySelector('#focused-link').focus();
                }
                break;
            case 'k':
                if (document.getElementById('focused-card') !== document.querySelector('.cards').firstElementChild) {
                    const nextCard = document.getElementById('focused-card');
                    const targetCard = nextCard.previousElementSibling;
                    nextCard.removeAttribute('id');
                    targetCard.setAttribute('id', 'focused-card');
                    targetCard.querySelector('.card-link').setAttribute('id', 'focused-link');
                    targetCard.querySelector('#focused-link').focus();
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
                targetStar.classList.toggle('starred');
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
        firstCard.setAttribute('id', 'focused-card');
        firstCard.querySelector('.card-link').setAttribute('id', 'focused-link');
        firstCard.querySelector('#focused-link').focus();
    }

    document.addEventListener('keydown', shortcut);

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
    });
});
