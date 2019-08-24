document.addEventListener('turbolinks:load', function () {
    // let shortcut = (e) => {
    function shortcut(e) {
        const keyName = e.key;
        switch (keyName) {
            case 'j':
                if (focusedCard !== cards.lastElementChild) {
                    focusedCard.removeAttribute('id');
                    nextCard.setAttribute('id', 'focused-card');
                    if (nextFlag === 1) {
                        cards.scrollTop = cards.scrollTop + (107 * cardPerPage);
                    }
                    nextCard.querySelector('.card-link').focus();

                    // 監視終了
                    nextCardObserver.unobserve(nextCard);
                    if (previousCard) {
                        previousCardObserver.unobserve(previousCard);
                    }

                    // 変数更新
                    previousCard = focusedCard;
                    focusedCard = nextCard;
                    nextCard = focusedCard.nextElementSibling;

                    // 監視開始
                    if (nextCard) {
                        nextCardObserver.observe(nextCard);
                    }
                    previousCardObserver.observe(previousCard);
                }
                break;
            case 'k':
                if (focusedCard !== cards.firstElementChild) {
                    focusedCard.removeAttribute('id');
                    previousCard.setAttribute('id', 'focused-card');
                    if (previousFlag === 1) {
                        cards.scrollTop = cards.scrollTop - (107 * cardPerPage);
                    }
                    previousCard.querySelector('.card-link').focus();

                    // 監視終了
                    if (nextCard) {
                        nextCardObserver.unobserve(nextCard);
                    }
                    previousCardObserver.unobserve(previousCard);

                    // 変数更新
                    nextCard = focusedCard;
                    focusedCard = previousCard;
                    previousCard = focusedCard.previousElementSibling;

                    // 監視開始
                    nextCardObserver.observe(nextCard);
                    if (previousCard) {
                        previousCardObserver.observe(previousCard);
                    }
                }
                break;
            case 'g':
                {
                    window.location.href = focusedCard.querySelector('.card-link');
                    break;
                }
            case 't':
                {
                    window.open(focusedCard.querySelector('.card-link'), '_blank');
                    break;
                }
            case 's':
                {
                    focusedCard.querySelector('.star').click();
                    focusedCard.querySelector('.star').classList.toggle('starred');
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

    let focusedCard = document.getElementById('focused-card');
    let nextCard = focusedCard.nextElementSibling;
    let previousCard = focusedCard.previousElementSibling;
    let nextFlag = 0;
    let previousFlag = 0;
    const cards = document.getElementById('mycards');
    const cardPerPage = Math.floor((window.innerHeight - 56) / (focusedCard.offsetHeight + 3));

    const nextCardObserver = new IntersectionObserver((entries, observer) => {
        if (!entries[0].isIntersecting) { // 完全に見えていないなら(見切れているなら)
            nextFlag = 1;
        } else {
            nextFlag = 0;
        }
    }, { root: cards, threshold: 1.0 });
    const previousCardObserver = new IntersectionObserver((entries, observer) => {
        if (!entries[0].isIntersecting) { // 完全に見えていないなら(見切れているなら)
            previousFlag = 1;
        } else {
            previousFlag = 0;
        }
    }, { root: cards, threshold: 1.0 });

    document.addEventListener('keydown', shortcut);

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
    });
});
