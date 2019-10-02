'use strict';

document.addEventListener('turbolinks:load', () => {
    const shortcut = (e) => {
        if (document.activeElement.className !== 'form-control') {
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
                    goFlag = false;
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
                    goFlag = false;
                    break;
                case 'o':
                    focusedCard.querySelector('.card-link').click();
                    goFlag = false;
                    break;
                case 't':
                    window.open(focusedCard.querySelector('.card-link'), '_blank');
                    goFlag = false;
                    break;
                case 'g':
                    goFlag = true;
                    gKeyDownTime = new Date;
                    break;
                case 'a':
                    if (goFlag && (new Date - gKeyDownTime < 1000)) {
                        window.location.href = document.getElementById('all');
                    }
                    goFlag = false;
                    break;
                case 's':
                    if (goFlag && (new Date - gKeyDownTime < 1000)) {
                        window.location.href = document.getElementById('starred');
                    } else {
                        focusedCard.querySelector('.fa-star').click();
                    }
                    goFlag = false;
                    break;
                case 'n':
                    if (goFlag && (new Date - gKeyDownTime < 1000)) {
                        window.location.href = document.getElementById('new');
                    }
                    goFlag = false;
                    break;
                case 'h':
                    if (goFlag && (new Date - gKeyDownTime < 1000)) {
                        window.location.href = document.getElementById('shortcuts');
                    }
                    goFlag = false;
                    break;
                case 'c':
                    if (goFlag && (new Date - gKeyDownTime < 1000)) {
                        window.location.href = document.getElementById('config');
                    }
                    goFlag = false;
                    break;
            }
        }
    }

    const focusSearchForm = (e) => {
        if (document.activeElement.className !== 'form-control') {
            const keyName = e.key;
            if (keyName == '/') {
                document.getElementById('search-form').focus();
                goFlag = false;
            }
        }
    }

    const toggleStar = (e) => {
        e.classList.toggle('far');
        e.classList.toggle('fas');
    }

    const removeAlert = () => {
        alertElement.style.display = 'none';
        document.removeEventListener('animationend', removeAlert);
    }

    const controller = document.body.dataset.controller;
    const action = document.body.dataset.action;
    const controllerAndAction = controller + '#' + action;
    const articlesCountElement = document.getElementById('articles-count');
    let articlesCount = articlesCountElement.dataset.count;
    const headerHeight = document.querySelector('header').offsetHeight;
    const alertElement = document.querySelector('.alert') ? document.querySelector('.alert') : undefined;
    const sidebar = document.getElementById('sidebar');
    const favicon = document.querySelector('.favicon');
    const faviconHeight = favicon ? favicon.offsetHeight : undefined;
    const faviconMargin = favicon ? parseInt(window.getComputedStyle(favicon).margin) : undefined;
    const faviconHeightAndMargin = favicon ? faviconHeight + faviconMargin : undefined;
    if (sidebar) {
        const faviconPerPage = Math.floor((window.innerHeight - headerHeight) / faviconHeightAndMargin)
        // const faviconPerPage = Math.floor((window.innerHeight - headerHeight - faviconHeightAndMargin) / faviconHeightAndMargin)トグルボタンありのとき
        if (document.getElementsByClassName('favicon').length <= faviconPerPage) {
            sidebar.style.width = '52px';
        }
    }
    const cardArea = document.getElementById('mycard-area');
    const cards = document.getElementsByClassName('mycard');
    const firstCard = document.querySelector('.mycard');
    const cardHeight = firstCard ? firstCard.offsetHeight : undefined;
    const cardMargin = firstCard ? parseInt(window.getComputedStyle(firstCard).marginBottom) : undefined;
    const lazyLoads = document.querySelectorAll('.lazyload');
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
    let goFlag = false;
    let gKeyDownTime;
    const ajaxData = { ajax: 'unread' };

    if ((controllerAndAction === 'feeds#new') || (controllerAndAction === 'feeds#edit')) {
        const submit = document.getElementById('submit');
        const spinner = document.getElementById('spinner');
        document.addEventListener('submit', () => {
            submit.style.display = 'none';
            spinner.style.display = 'block';
        });
    }

    if ((controllerAndAction === 'feeds#unread') && alertElement) {
        document.addEventListener('animationend', removeAlert);
    }

    const lazyLoadObserver = new IntersectionObserver((entries, observer) => {
        // threshold: 0でのentries[0].isIntersectingは、cardAreaに少しでも入ったときにtrue、cardAreaから完全に出たときにfalse
        entries.forEach(entry => {
            if (entry.isIntersecting) { // cardAreaに少しでも入ったとき
                entry.target.setAttribute('src', entry.target.dataset.src);
                lazyLoadObserver.unobserve(entry.target);
            }
        });
    }, { root: cardArea, threshold: 0 });

    if ((controllerAndAction === 'articles#unread') || (controllerAndAction === 'articles#starred') || (controllerAndAction === 'feeds#unread')) {
        Array.prototype.forEach.call(lazyLoads, lazyLoad => {
            lazyLoadObserver.observe(lazyLoad);
        });
    }

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
                });
                // }).then(res => res.json())
                //     .then(response => console.log('Success:', JSON.stringify(response)))
                //     .catch(error => console.error('Error:', error));
                entry.target.classList.add('read');
                --articlesCount;
                articlesCountElement.querySelector('span').textContent = `(${articlesCount})`;
                readObserver.unobserve(entry.target);
            }
        });
    }, { root: cardArea, threshold: 0 });

    if ((controllerAndAction === 'articles#unread') || (controllerAndAction === 'feeds#unread')) {
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

    if (controllerAndAction !== 'static_pages#welcome') {
        document.addEventListener('keydown', shortcut);
        document.addEventListener('keyup', focusSearchForm);
    }
    Array.prototype.forEach.call(stars, star => {
        star.addEventListener('click', () => { toggleStar(star); });
    });

    document.addEventListener('turbolinks:load', () => {
        document.removeEventListener('keydown', shortcut);
        document.removeEventListener('keyup', focusSearchForm);
        Array.prototype.forEach.call(stars, star => {
            star.removeEventListener('click', toggleStar);
        });
    });
});
