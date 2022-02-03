const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
    content: [
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/views/**/*',
    ],
    theme: {
        extend: {
            fontFamily: {
                sans: ['Inter var', ...defaultTheme.fontFamily.sans],
            },
            colors: {
                'brand-blue': {
                    700: '#7C9AC0',
                    800: '#526583',
                    900: '#232D42',
                },
            },
        },
    },
    plugins: [
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
        require('@tailwindcss/typography'),
        require('@themesberg/flowbite/plugin'),
    ],
};
