// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
// import '@themesberg/flowbite';
import 'boxicons';

//= require masonry/jquery.masonry
//= require masonry/masonry

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import { createPopper } from '@popperjs/core';

const toggleCollapse = (elementId, show = true) => {
    const collapseEl = document.getElementById(elementId);
    if (show) {
        collapseEl.classList.remove('hidden');
    } else {
        collapseEl.classList.add('hidden');
    }
};

const toggleModal = (modalId, show = true) => {
    const modalEl = document.getElementById(modalId);

    if (show) {
        modalEl.classList.add('flex');
        modalEl.classList.remove('hidden');
        modalEl.setAttribute('aria-modal', 'true');
        modalEl.setAttribute('role', 'dialog');
        modalEl.removeAttribute('aria-hidden');

        // create backdrop element
        var backdropEl = document.createElement('div');
        backdropEl.setAttribute('modal-backdrop', '');
        backdropEl.classList.add(
            'bg-gray-900',
            'bg-opacity-50',
            'dark:bg-opacity-80',
            'fixed',
            'inset-0',
            'z-40'
        );
        document.querySelector('body').append(backdropEl);
    } else {
        modalEl.classList.add('hidden');
        modalEl.classList.remove('flex');
        modalEl.setAttribute('aria-hidden', 'true');
        modalEl.removeAttribute('aria-modal');
        modalEl.removeAttribute('role');
        document.querySelector('[modal-backdrop]').remove();
    }
};

$(document).on('turbolinks:load', () => {
    //modal
    document
        .querySelectorAll('[data-modal-toggle]')
        .forEach(function (modalToggleEl) {
            var modalId = modalToggleEl.getAttribute('data-modal-toggle');
            var modalEl = document.getElementById(modalId);

            if (modalEl) {
                if (
                    !modalEl.hasAttribute('aria-hidden') &&
                    !modalEl.hasAttribute('aria-modal')
                ) {
                    modalEl.setAttribute('aria-hidden', 'true');
                }

                modalToggleEl.addEventListener('click', function () {
                    toggleModal(
                        modalId,
                        modalEl.hasAttribute('aria-hidden', 'true')
                    );
                });
            }
        });

    // Toggle target elements using [data-collapse-toggle]
    document
        .querySelectorAll('[data-collapse-toggle]')
        .forEach(function (collapseToggleEl) {
            var collapseId = collapseToggleEl.getAttribute(
                'data-collapse-toggle'
            );

            collapseToggleEl.addEventListener('click', function () {
                toggleCollapse(
                    collapseId,
                    document
                        .getElementById(collapseId)
                        .classList.contains('hidden')
                );
            });
        });
    // Toggle dropdown elements using [data-dropdown-toggle]
    document
        .querySelectorAll('[data-dropdown-toggle]')
        .forEach(function (dropdownToggleEl) {
            const dropdownMenuId = dropdownToggleEl.getAttribute(
                'data-dropdown-toggle'
            );
            const dropdownMenuEl = document.getElementById(dropdownMenuId);

            // options
            const placement = dropdownToggleEl.getAttribute(
                'data-dropdown-placement'
            );

            dropdownToggleEl.addEventListener('click', function (event) {
                var element = event.target;
                while (element.nodeName !== 'BUTTON') {
                    element = element.parentNode;
                }

                createPopper(element, dropdownMenuEl, {
                    placement: placement ? placement : 'bottom-start',
                    modifiers: [
                        {
                            name: 'offset',
                            options: {
                                offset: [0, 10],
                            },
                        },
                    ],
                });

                // toggle when click on the button
                dropdownMenuEl.classList.toggle('hidden');
                dropdownMenuEl.classList.toggle('block');

                function handleDropdownOutsideClick(event) {
                    var targetElement = event.target; // clicked element
                    if (
                        targetElement !== dropdownMenuEl &&
                        targetElement !== dropdownToggleEl &&
                        !dropdownToggleEl.contains(targetElement)
                    ) {
                        dropdownMenuEl.classList.add('hidden');
                        dropdownMenuEl.classList.remove('block');
                        document.body.removeEventListener(
                            'click',
                            handleDropdownOutsideClick,
                            true
                        );
                    }
                }

                // hide popper when clicking outside the element
                document.body.addEventListener(
                    'click',
                    handleDropdownOutsideClick,
                    true
                );
            });
        });

    // Toggle dropdown elements using [data-dropdown-toggle]
    document
        .querySelectorAll('[data-tooltip-target]')
        .forEach(function (tooltipToggleEl) {
            const tooltipEl = document.getElementById(
                tooltipToggleEl.getAttribute('data-tooltip-target')
            );
            const placement = tooltipToggleEl.getAttribute(
                'data-tooltip-placement'
            );
            const trigger = tooltipToggleEl.getAttribute(
                'data-tooltip-trigger'
            );

            const popperInstance = createPopper(tooltipToggleEl, tooltipEl, {
                placement: placement ? placement : 'top',
                modifiers: [
                    {
                        name: 'offset',
                        options: {
                            offset: [0, 8],
                        },
                    },
                ],
            });

            function show() {
                // Make the tooltip visible
                tooltipEl.classList.remove('opacity-0');
                tooltipEl.classList.add('opacity-100');
                tooltipEl.classList.remove('invisible');
                tooltipEl.classList.add('visible');

                // Enable the event listeners
                popperInstance.setOptions((options) => ({
                    ...options,
                    modifiers: [
                        ...options.modifiers,
                        { name: 'eventListeners', enabled: true },
                    ],
                }));

                // Update its position
                popperInstance.update();
            }

            function hide() {
                // Hide the tooltip
                tooltipEl.classList.remove('opacity-100');
                tooltipEl.classList.add('opacity-0');
                tooltipEl.classList.remove('visible');
                tooltipEl.classList.add('invisible');

                // Disable the event listeners
                popperInstance.setOptions((options) => ({
                    ...options,
                    modifiers: [
                        ...options.modifiers,
                        { name: 'eventListeners', enabled: false },
                    ],
                }));
            }

            var showEvents = [];
            var hideEvents = [];

            switch (trigger) {
                case 'hover':
                    showEvents = ['mouseenter', 'focus'];
                    hideEvents = ['mouseleave', 'blur'];
                    break;
                case 'click':
                    showEvents = ['click', 'focus'];
                    hideEvents = ['focusout', 'blur'];
                    break;
                default:
                    showEvents = ['mouseenter', 'focus'];
                    hideEvents = ['mouseleave', 'blur'];
            }

            showEvents.forEach((event) => {
                tooltipToggleEl.addEventListener(event, show);
            });

            hideEvents.forEach((event) => {
                tooltipToggleEl.addEventListener(event, hide);
            });
        });
});

window.toggleCollapse = toggleCollapse;

window.toggleModal = toggleModal;
