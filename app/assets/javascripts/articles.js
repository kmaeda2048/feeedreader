'use strict';

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
                window.location.href = focusedCard.querySelector('.card-link');
                break;
            case 't':
                window.open(focusedCard.querySelector('.card-link'), '_blank');
                break;
            case 's':
                focusedCard.querySelector('.fa-star').click();
                break;
            case 'a':
                window.location.href = document.getElementById('all');
                break;
            case 'q':
                window.location.href = document.getElementById('starred');
                break;
        }
    }

    function toggleStar(e) {
        e.classList.toggle('far');
        e.classList.toggle('fas');
    }

    // const controller = document.body.dataset.controller;
    // const action = document.body.dataset.action;

    const headerHeight = document.querySelector('header').offsetHeight;
    const faviconHeight = document.querySelector('.favicon').offsetHeight;
    const faviconMargin = parseInt(window.getComputedStyle(document.querySelector('.favicon')).margin);
    const faviconHeightAndMargin = faviconHeight + faviconMargin;
    const cards = document.getElementById('mycards');
    const firstCard = document.querySelector('.mycard') ? document.querySelector('.mycard') : undefined;
    const cardHeight = firstCard ? firstCard.offsetHeight : undefined; // 最初のカードの高さ(他のカードの中には高さが異なるものが存在する可能性あり)
    const cardMargin = firstCard ? parseInt(window.getComputedStyle(firstCard).marginBottom) : undefined;
    if (firstCard) {
        firstCard.setAttribute('id', 'focused-card');
        firstCard.querySelector('.card-link').focus();
    }
    let focusedCard = document.getElementById('focused-card') ? document.getElementById('focused-card') : undefined;
    let nextCard = focusedCard && focusedCard.nextElementSibling ? focusedCard.nextElementSibling : undefined;
    let previousCard;
    let nextFlag = 0;
    let previousFlag = 0;
    const cardPerPage = Math.floor((window.innerHeight - headerHeight) / (cardHeight + cardMargin));
    const stars = document.getElementsByClassName('toggleable-star');

    if (document.getElementById('sidebar')) {
        const faviconPerPage = Math.floor((window.innerHeight - headerHeight - faviconHeightAndMargin) / faviconHeightAndMargin)
        if (document.getElementsByClassName('favicon').length <= faviconPerPage) {
            document.getElementById('sidebar').style.width = '52px';
        }
    }

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
    for (let i = 0; i < stars.length; ++i) {
        stars[i].addEventListener('click', () => { toggleStar(stars[i]); });
    }

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
        for (let i = 0; i < stars.length; ++i) {
            stars[i].removeEventListener('click', toggleStar);
        }
    });
});
