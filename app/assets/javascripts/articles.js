'use strict';

document.addEventListener('turbolinks:load', function () {
    // let shortcut = (e) => {
    function shortcut(e) {
        const keyName = e.key;
        switch (keyName) {
            case 'j':
                if (focusedCard !== cardArea.lastElementChild) {
                    focusedCard.removeAttribute('id');
                    nextCard.setAttribute('id', 'focused-card');
                    if (nextFlag === 1) {
                        cardArea.scrollTop = cardArea.scrollTop + ((cardHeight + cardMargin) * cardPerPage);
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
                if (focusedCard !== cardArea.firstElementChild) {
                    focusedCard.removeAttribute('id');
                    previousCard.setAttribute('id', 'focused-card');
                    if (previousFlag === 1) {
                        cardArea.scrollTop = cardArea.scrollTop - ((cardHeight + cardMargin) * cardPerPage);
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
                focusedCard.querySelector('.card-link').click();
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
            case 'c':
                window.location.href = document.getElementById('config');
                break;
        }
    }

    function toggleStar(e) {
        e.classList.toggle('far');
        e.classList.toggle('fas');
    }

    const controller = document.body.dataset.controller;
    const action = document.body.dataset.action;
    const articlesCountElement = document.getElementById('articles-count');
    let articlesCount = articlesCountElement.dataset.count;
    const controllerAndAction = controller + '#' + action;
    const headerHeight = document.querySelector('header').offsetHeight;
    const sidebar = document.getElementById('sidebar');
    const favicon = document.querySelector('.favicon');
    const faviconHeight = favicon ? favicon.offsetHeight : undefined;
    const faviconMargin = favicon ? parseInt(window.getComputedStyle(favicon).margin) : undefined;
    const faviconHeightAndMargin = favicon ? faviconHeight + faviconMargin : undefined;
    if (sidebar) {
        const faviconPerPage = Math.floor((window.innerHeight - headerHeight - faviconHeightAndMargin) / faviconHeightAndMargin)
        if (document.getElementsByClassName('favicon').length <= faviconPerPage) {
            sidebar.style.width = '52px';
        }
    }
    const cardArea = document.getElementById('mycard-area');
    const cards = document.getElementsByClassName('mycard');
    const firstCard = document.querySelector('.mycard');
    const cardHeight = firstCard ? firstCard.offsetHeight : undefined;
    const cardMargin = firstCard ? parseInt(window.getComputedStyle(firstCard).marginBottom) : undefined;
    const stars = document.getElementsByClassName('toggleable-star');
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
    const ajaxData = { ajax: 'unread' };

    const readObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            // threshold: 0でのentries[0].isIntersectingは、cardAreaに少しでも入ったときにtrue、cardAreaから完全に出たときにfalse
            if ((!entry.isIntersecting) && (entry.boundingClientRect.y < 0)) { // cardAreaから完全に出た&&上に出た
                const articleId = entry.target.dataset.articleId;
                const url = '/articles/' + articleId;
                fetch(url, {
                    method: 'PUT',
                    headers: {
                        'X-CSRF-Token': Rails.csrfToken(),
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(ajaxData), // data can be `string` or {object}!
                    credentials: 'same-origin'
                })
                // }).then(res => res.json())
                //     .then(response => console.log('Success:', JSON.stringify(response)))
                //     .catch(error => console.error('Error:', error));
                entry.target.classList.add('read');
                --articlesCount;
                nowPage.querySelector('span').textContent = `(${articlesCount})`;
                readObserver.unobserve(entry.target);
            }
        });
    }, { root: cardArea, threshold: 0 });

    if ((controllerAndAction === 'articles#unread') || (controllerAndAction === 'feeds#show')) {
        Array.prototype.forEach.call(cards, card => {
            readObserver.observe(card);
        });
    }

    const nextCardObserver = new IntersectionObserver((entries, observer) => {
        // threshold: 1.0でのentries[0].isIntersectingは、cardAreaに完全に入ったときにtrue、cardAreaから少しでも出たときにfalse
        if (!entries[0].isIntersecting) { // cardAreaから少しでも出たとき
            nextFlag = 1;
        } else {
            nextFlag = 0;
        }
    }, { root: cardArea, threshold: 1.0 });
    const previousCardObserver = new IntersectionObserver((entries, observer) => {
        // threshold: 1.0でのentries[0].isIntersectingは、cardAreaに完全に入ったときにtrue、cardAreaから少しでも出たときにfalse
        if (!entries[0].isIntersecting) { // cardAreaから少しでも出たとき
            previousFlag = 1;
        } else {
            previousFlag = 0;
        }
    }, { root: cardArea, threshold: 1.0 });

    if ((controllerAndAction !== 'static_pages#welcome') && (controllerAndAction !== 'feeds#new') && (controllerAndAction !== 'feeds#edit')) {
        document.addEventListener('keydown', shortcut);
    }
    Array.prototype.forEach.call(stars, star => {
        star.addEventListener('click', () => { toggleStar(star); });
    });

    document.addEventListener('turbolinks:load', function () {
        document.removeEventListener('keydown', shortcut);
        Array.prototype.forEach.call(stars, star => {
            star.removeEventListener('click', toggleStar);
        });
    });
});
