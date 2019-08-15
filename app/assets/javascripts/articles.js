function shortcut(event) {
    const keyName = event.key;
    switch (keyName) {
        case "j":
            if (document.activeElement.className != 'focus') {
                const first_card = document.querySelector('.card');
                first_card.setAttribute('id', 'target');
                first_card.querySelector('.focus').focus();
                first_card.querySelector('.focus').style.outline = "none";
                first_card.style.backgroundColor = "lightcyan";
            } else {
                const previous_card = document.getElementById('target');
                const target_card = previous_card.nextElementSibling;
                previous_card.style.backgroundColor = "";
                previous_card.removeAttribute('id');
                target_card.setAttribute('id', 'target');
                target_card.querySelector('.focus').focus();
                target_card.querySelector('.focus').style.outline = "none";
                target_card.style.backgroundColor = "lightcyan";
            }
            break;
        case "k":
            if (document.activeElement.className == 'focus') {
                const next_card = document.getElementById('target');
                const target_card = next_card.previousElementSibling;
                next_card.style.backgroundColor = "";
                next_card.removeAttribute('id');
                target_card.setAttribute('id', 'target');
                target_card.querySelector('.focus').focus();
                target_card.querySelector('.focus').style.outline = "none";
                target_card.style.backgroundColor = "lightcyan";
            }
            break;
        case "o":
            if (document.activeElement.className == 'focus') {
                const target_link = document.getElementById('target').querySelector('.focus');
                window.location.href = target_link;
            }
            break;
        case "g":
            if (document.activeElement.className == 'focus') {
                const target_link = document.getElementById('target').querySelector('.focus');
                window.open(target_link, '_blank');
            }
            break;
        case "s":
            console.log('スターのトグル');
            break;
    }
}

function star_style(event) {
    const clicked = event.target.className;
    console.log(clicked);

    if (clicked == 'star') {
        if (event.target.style.backgroundColor == "") {
            event.target.style.backgroundColor = "yellow";
        } else {
            event.target.style.backgroundColor = "";
        }
    }
}

document.addEventListener('turbolinks:load', function () {
    const controller = document.querySelector('body').dataset.controller;
    const action = document.querySelector('body').dataset.action;

    if (controller == "articles" && (action == "index" || action == "starred")) {
        document.addEventListener('keydown', shortcut);
        document.addEventListener('click', star_style);
        // document.getElementsByClassName('star').addEventListener('click', star_style);

        // for (let i = 0; i < 2; i++) {
        //     elmA[i].addEventListener('click', () => {
        //         elmB[i].classList.add('is-active');
        //     });
        // }


    } else {
        document.removeEventListener('keydown', shortcut);
        // document.getElementsByClassName('star').removeEventListener('click', star_style);
    }
});
